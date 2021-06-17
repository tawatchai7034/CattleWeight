import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
ConvertHex hex = new ConvertHex();

class ChartCattle extends StatelessWidget {
  const ChartCattle({Key? key,required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),
      body: ChartData(title),
    );

  }
}

// ต้นแบบ https://youtu.be/zhcxdh4-Jt8
class ChartData extends StatefulWidget {
  late String title;
  ChartData(this.title);

  @override
  _ChartDataState createState() => _ChartDataState();
}

class _ChartDataState extends State<ChartData> {
  late List<SalesData> _chartData;
  late TooltipBehavior _tooltipBehavior;


  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
      title: ChartTitle(text: 'อัตราการเจริญเติบโตของ ${widget.title}'),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<SalesData, double>(
            name: 'อัตราการเจริญเติบโต',
            dataSource: _chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true)
      ],
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
    )));
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30)
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
