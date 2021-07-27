package com.example.cattle_weight

import java.io.InputStream
import java.io.OutputStream
import java.io.IOException
import java.nio.charset.Charset
import java.util.ArrayList
import java.util.HashMap
import java.util.UUID
import android.os.Handler
import android.os.Bundle
import android.os.Message
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothServerSocket
import android.bluetooth.BluetoothSocket
import android.bluetooth.BluetoothDevice
import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ActivityInfo


class MainActivity : FlutterActivity() {
    private inner class BluetoothConnection internal constructor(bluetoothSocket: BluetoothSocket) : Thread() {
        private var bluetoothSocket: BluetoothSocket? = null
        private var inputStream: InputStream? = null
        private var outputStream: OutputStream? = null
        fun initializeStreams(socket: BluetoothSocket) {
            bluetoothSocket = socket
            try {
                inputStream = socket.inputStream
                outputStream = socket.outputStream
            } catch (e: IOException) {
                e.printStackTrace()
            }
        }

        @Throws(IOException::class)
        fun read(buffer: ByteArray?) {
            val bytes = inputStream!!.read(buffer)
            systemHandler!!.obtainMessage(RECEIVE_MESSAGE, bytes, -1, buffer).sendToTarget()
        }

        @Throws(IOException::class)
        fun write(data: String) {
            val messageBuffer = data.toByteArray()
            outputStream!!.write(messageBuffer)
        }

        override fun run() {
            val buffer = ByteArray(256)
            while (true) {
                try {
                    read(buffer)
                } catch (e: IOException) {
                    e.printStackTrace()
                }
            }
        }

        @Throws(IOException::class)
        fun disconnect() {
            bluetoothSocket!!.close()
        }

        init {
            initializeStreams(bluetoothSocket)
        }
    }

    var mBluetoothAdapter: BluetoothAdapter? = null
    private var bluetoothConnectionState = false
    private var bluetoothConnection: BluetoothConnection? = null
    private var bluetoothSocket: BluetoothSocket? = null
    private val inputStream: InputStream? = null
    private val outputStream: OutputStream? = null
    private var channel: MethodChannel? = null
    private var systemHandler: Handler? = null
    private val messageData = StringBuilder()
    private var toOutputDataBuilder: String! = null
    private val BLUETOOTH_UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")
    private val RECEIVE_MESSAGE = 1
    @SuppressLint("HandlerLeak")
    private fun setupHandler() {
        systemHandler = object : Handler() {
            override fun handleMessage(msg: Message) {
                if (msg.what != RECEIVE_MESSAGE) {
                    return
                }
                val readBuffer = msg.obj as ByteArray
                val strInCOM = String(readBuffer, 0, msg.arg1)
                messageData.append(strInCOM)
                val endOfLineIndex = messageData.indexOf(":")
                if (endOfLineIndex > 0) {
                    toOutputDataBuilder = messageData.substring(0, endOfLineIndex)
                    messageData.delete(0, messageData.length)
                    val data = toOutputDataBuilder.trim { it <= ' ' }
                    channel!!.invokeMethod("message", toOutputDataBuilder)
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        setupHandler()
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        channel = MethodChannel(flutterView, CHANNEL)
        channel!!.setMethodCallHandler { call, result -> handleMethod(call, result) }
    }

    private fun handleMethod(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "enumerate-devices" -> enumerateDevices(result)
            "connect" -> connect(call, result)
            "transmit" -> transmit(call)
        }
    }

    private fun enumerateDevices(result: MethodChannel.Result) {
        val pairedDevices = bluetoothAdapter!!.bondedDevices
        if (pairedDevices.size > 0) {
            val devices = ArrayList<Map<*, *>>()
            for (device in pairedDevices) {
                val info: MutableMap<String, String> = HashMap()
                info[device.name] = device.address
                devices.add(info)
            }
            result.success(devices)
        }
    }

    private fun connect(call: MethodCall, result: MethodChannel.Result) {
        val BtDevice = bluetoothAdapter!!.getRemoteDevice(call.arguments.toString())
        try {
            bluetoothSocket = BtDevice.createRfcommSocketToServiceRecord(BLUETOOTH_UUID)
            bluetoothSocket.connect()
            bluetoothConnection = BluetoothConnection(bluetoothSocket)
            bluetoothConnection!!.start()
            bluetoothConnectionState = true
        } catch (e: IOException) {
            try {
                bluetoothSocket!!.close()
            } catch (e1: IOException) {
                e1.printStackTrace()
            }
        }
    }

    private fun transmit(call: MethodCall) {
        try {
            val data = call.arguments.toString()
            bluetoothConnection!!.outputStream!!.write(data.toByteArray(Charset.forName("UTF-8")))
        } catch (e: IOException) {
        }
    }

    companion object {
        private var bluetoothAdapter: BluetoothAdapter? = null
        private const val CHANNEL = "flutter.native/helper"
    }
}
