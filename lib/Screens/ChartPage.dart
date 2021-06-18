import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
ConvertHex hex = new ConvertHex();

class ChartCattle extends StatelessWidget {
  const ChartCattle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(hex.hexColor("#007BA4")),
        actions: [MenuBar()],
      ),
      body: ChartData(title),
    );
  }
}

// ต้นแบบ https://youtu.be/zhcxdh4-Jt8
// https://help.syncfusion.com/flutter/cartesian-charts/getting-started
// https://help.syncfusion.com/flutter/cartesian-charts/axis-customization
class ChartData extends StatefulWidget {
  late String title;
  ChartData(this.title);

  @override
  _ChartDataState createState() => _ChartDataState();
}

class _ChartDataState extends State<ChartData> {
  late List<CattleData> _chartData;
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
        LineSeries<CattleData, double>(
            name: 'อัตราการเจริญเติบโต',
            dataSource: _chartData,
            xValueMapper: (CattleData cattle, _) => cattle.month,
            yValueMapper: (CattleData cattle, _) => cattle.weight,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
            color: Color(hex.hexColor("#FAA41B")))
      ],
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          numberFormat: NumberFormat.compact(),
          anchorRangeToVisiblePoints: false),
    )));
  }

  List<CattleData> getChartData() {
    final List<CattleData> chartData = [
      CattleData(1, 2525),
      CattleData(2, 1212),
      CattleData(3, 2424),
      CattleData(4, 1818),
      CattleData(5, 3030),
      CattleData(6, 2525),
      CattleData(7, 1212),
      CattleData(8, 2424),
      CattleData(9, 1818),
      CattleData(10, 3030)
    ];
    return chartData;
  }
}

class CattleData {
  CattleData(this.month, this.weight);
  final double month;
  final double weight;
}

class SectionPage extends StatelessWidget {
  const SectionPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ChartData("cattle256"),
        Container(
          child: Card(),
        ),
      ],
    );
  }
}
class MenuBar extends StatelessWidget {
  const MenuBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.menu),
        // เมื่อเลือกเมนูแล้วจะส่งไปทำงานที่หังก์ชัน onSelected
        onSelected: (item) => onSelected(context, item),
        itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: ListTile(
                    leading: Icon(Icons.assignment_outlined),
                    title: Text("Export"),
                  )),
            //   PopupMenuItem<int>(
            //       value: 1,
            //       child: ListTile(
            //         leading: Icon(Icons.edit),
            //         title: Text("Edit"),
            //       ))
            ]);
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ExportFile()));
      break;
    // case 1:
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => EditOption()));
    //   break;
  }
}

class ExportFile extends StatelessWidget {
  const ExportFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export File"),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),
      body: Center(
        child: Text("Export File page"),
      ),
    );
  }
}
