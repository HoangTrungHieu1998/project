import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart/bar_chart.dart';
import 'package:flutter_chart/pie_chart.dart';
import 'package:flutter_chart/plot_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'line_chart.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<DeveloperSeries> data = [
    DeveloperSeries(
      year: "2017",
      developers: 10000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    DeveloperSeries(
      year: "2018",
      developers: 15000,
      barColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    DeveloperSeries(
      year: "2019",
      developers: 4000,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    DeveloperSeries(
      year: "2020",
      developers: 5000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    DeveloperSeries(
      year: "2021",
      developers: 2000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];
  final List<DeveloperSeries> data1 = [
    DeveloperSeries(
      year: "2017",
      developers: 20000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green.shade200),
    ),
    DeveloperSeries(
      year: "2018",
      developers: 5000,
      barColor: charts.ColorUtil.fromDartColor(Colors.yellow.shade200),
    ),
    DeveloperSeries(
      year: "2019",
      developers: 24000,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple.shade200),
    ),
    DeveloperSeries(
      year: "2020",
      developers: 35000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red.shade200),
    ),
    DeveloperSeries(
      year: "2021",
      developers: 45000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue.shade200),
    ),
  ];
  final List<LinearSales> pieData = [
    LinearSales(
      year: 2017,
      sales: 20000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    LinearSales(
      year: 2018,
      sales: 5000,
      barColor: charts.ColorUtil.fromDartColor(Colors.black),
    ),
    LinearSales(
      year: 2019,
      sales: 24000,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    LinearSales(
      year: 2020,
      sales: 35000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    LinearSales(
      year: 2021,
      sales: 45000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];
  final List<DepositMoney> lineData = [
    DepositMoney(
      year: 0,
      money: 5,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    DepositMoney(
      year: 1,
      money: 15,
      barColor: charts.ColorUtil.fromDartColor(Colors.black),
    ),
    DepositMoney(
      year: 2,
      money: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    DepositMoney(
      year: 3,
      money: 30,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    DepositMoney(
      year: 4,
      money: 5,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];
  final List<DepositMoney> lineData1 = [
    DepositMoney(
      year: 0,
      money: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    DepositMoney(
      year: 1,
      money: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.black),
    ),
    DepositMoney(
      year: 2,
      money: 30,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    DepositMoney(
      year: 3,
      money: 50,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    DepositMoney(
      year: 4,
      money: 15,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];
  final List<DepositMoney> lineData2 = [
    DepositMoney(
      year: 0,
      money: 15,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    DepositMoney(
      year: 1,
      money: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.black),
    ),
    DepositMoney(
      year: 2,
      money: 45,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    DepositMoney(
      year: 3,
      money: 70,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    DepositMoney(
      year: 4,
      money: 40,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];

  final List<Plot> plot = [
    Plot(52, 0.75, 14.0)
  ];
  final List<Plot> plot1 = [
    Plot(45, 0.3, 18.0)
  ];
  final List<Plot> plot2 = [
    Plot(56, 0.8, 17.0)
  ];
  final List<Plot> plot3 = [
    Plot(25, 0.6, 13.0)
  ];
  final List<Plot> plot4 = [
    Plot(34, 0.5, 15.0)
  ];
  final List<Plot> plot5 = [
    Plot(10, 0.25, 15.0),
    Plot(12, 0.075, 14.0),
    Plot(13, 0.225, 15.0),
    Plot(16, 0.03, 14.0),
    Plot(24, 0.04, 13.0),
    Plot(37, 0.1, 14.5),
  ];



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              indicatorColor: Colors.deepPurple,
              tabs: [
                Tab(icon: Icon(FontAwesomeIcons.solidChartBar),),
                Tab(icon: Icon(FontAwesomeIcons.chartPie),),
                Tab(icon: Icon(FontAwesomeIcons.chartLine),),
                Tab(icon: Icon(FontAwesomeIcons.chartArea),),
              ],
            ),
            title: const Text("Chart"),
          ),
          body: TabBarView(
            children: [
              SimpleBarChart(data: data,data1: data1,),
              SimplePieChart(pieData: pieData,),
              SimpleLineChart(lineData1: lineData1,lineData: lineData,lineData2: lineData2,),
              SimplePlotChart(plot: plot,plot1: plot1,plot2: plot2,plot3: plot3,plot4: plot4,plot5: plot5,),
            ],
          ),
        ),
      ),
    );
  }
}

