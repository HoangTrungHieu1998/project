import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SimplePieChart extends StatelessWidget {
  final List<LinearSales>? pieData;

  const SimplePieChart({Key? key,this.pieData,}):super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<LinearSales, int>> series = [
      charts.Series(
          id: "Sales",
          data: pieData!,
          domainFn: (LinearSales series, _) => series.year!,
          measureFn: (LinearSales series, _) => series.sales,
          colorFn: (LinearSales series, _) => series.barColor!,
          labelAccessorFn: (LinearSales series, _) => '${series.sales}',
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
                "Yearly Sales in the Hieu Company",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.PieChart<int>(
                    series,
                    animate: true,
                    animationDuration: const Duration(seconds: 2),
                    defaultRenderer: charts.ArcRendererConfig(
                        arcWidth: 60,
                        arcRendererDecorators: [charts.ArcLabelDecorator()])
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
class LinearSales {
  final int? year;
  final int? sales;
  final charts.Color? barColor;

  LinearSales(
      {
        @required this.year,
        @required this.sales,
        @required this.barColor
      }
      );
}