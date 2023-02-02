import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SimpleBarChart extends StatelessWidget {
  final List<DeveloperSeries>? data;
  final List<DeveloperSeries>? data1;

  const SimpleBarChart({Key? key,this.data,this.data1}):super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DeveloperSeries, String>> series = [
      charts.Series(
          id: "developers1",
          data: data!,
          domainFn: (DeveloperSeries series, _) => series.year!,
          measureFn: (DeveloperSeries series, _) => series.developers,
          colorFn: (DeveloperSeries series, _) => series.barColor!
      ),
      charts.Series(
          id: "developers2",
          data: data1!,
          domainFn: (DeveloperSeries series, _) => series.year!,
          measureFn: (DeveloperSeries series, _) => series.developers,
          colorFn: (DeveloperSeries series, _) => series.barColor!,
          fillPatternFn: (DeveloperSeries sales, _) =>
          charts.FillPatternType.forwardHatch,
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
                "Yearly Growth in the Flutter Community",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.BarChart(
                    series,
                    animate: true,
                    vertical: false,
                    animationDuration: const Duration(seconds: 2),
                    barGroupingType: charts.BarGroupingType.grouped,
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
class DeveloperSeries {
  final String? year;
  final int? developers;
  final charts.Color? barColor;

  DeveloperSeries(
      {
        @required this.year,
        @required this.developers,
        @required this.barColor
      }
      );
}