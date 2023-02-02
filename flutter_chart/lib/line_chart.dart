import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SimpleLineChart extends StatelessWidget {
  final List<DepositMoney>? lineData;
  final List<DepositMoney>? lineData1;
  final List<DepositMoney>? lineData2;

  const SimpleLineChart({Key? key,this.lineData,this.lineData1,this.lineData2}):super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DepositMoney, int>> series = [
      charts.Series(
        id: "Deposit 1",
        data: lineData!,
        domainFn: (DepositMoney series, _) => series.year!,
        measureFn: (DepositMoney series, _) => series.money,
        colorFn: (DepositMoney series, _) => charts.MaterialPalette.blue.shadeDefault,
        areaColorFn: (_, __) =>
        charts.MaterialPalette.blue.shadeDefault.lighter,
        labelAccessorFn: (DepositMoney series, _) => '${series.money}',
      ),
      charts.Series(
        id: "Deposit 2",
        data: lineData1!,
        domainFn: (DepositMoney series, _) => series.year!,
        measureFn: (DepositMoney series, _) => series.money,
        colorFn: (DepositMoney series, _) => charts.MaterialPalette.red.shadeDefault,
        areaColorFn: (_, __) =>
        charts.MaterialPalette.red.shadeDefault.lighter,
        labelAccessorFn: (DepositMoney series, _) => '${series.money}',
      ),
      charts.Series(
        id: "Deposit 3",
        data: lineData2!,
        domainFn: (DepositMoney series, _) => series.year!,
        measureFn: (DepositMoney series, _) => series.money,
        colorFn: (DepositMoney series, _) => charts.MaterialPalette.green.shadeDefault,
        areaColorFn: (_, __) =>
        charts.MaterialPalette.green.shadeDefault.lighter,
        labelAccessorFn: (DepositMoney series, _) => '${series.money}',
      )
    ];

    return Container(
      height: 300,
      padding: const EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Yearly Deposit money in the Hieu Company",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.LineChart(
                    series,
                    animate: true,
                    animationDuration: const Duration(seconds: 2),
                    defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: true),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Sample ordinal data type.
class DepositMoney {
  final int? year;
  final int? money;
  final charts.Color? barColor;

  DepositMoney(
      {
        @required this.year,
        @required this.money,
        @required this.barColor
      }
      );
}