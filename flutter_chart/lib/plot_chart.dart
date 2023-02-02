import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SimplePlotChart extends StatelessWidget {
  final List<Plot>? plot;
  final List<Plot>? plot1;
  final List<Plot>? plot2;
  final List<Plot>? plot3;
  final List<Plot>? plot4;
  final List<Plot>? plot5;

  const SimplePlotChart({Key? key,this.plot, this.plot1, this.plot2, this.plot3, this.plot4, this.plot5,}):super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Plot, int>> series = [
      charts.Series(
          id: 'Desktop',
          colorFn: (Plot sales, _) =>
          charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Plot sales, _) => sales.year,
          measureFn: (Plot sales, _) => sales.revenueShare,
          radiusPxFn: (Plot sales, _) => sales.radius,
          data: plot!
      ),
      charts.Series(
          id: 'Tablet',
          colorFn: (Plot sales, _) =>
          charts.MaterialPalette.red.shadeDefault,
          domainFn: (Plot sales, _) => sales.year,
          measureFn: (Plot sales, _) => sales.revenueShare,
          radiusPxFn: (Plot sales, _) => sales.radius,
          data: plot1!
      ),
      charts.Series(
          id: 'Mobile',
          colorFn: (Plot sales, _) =>
          charts.MaterialPalette.green.shadeDefault,
          domainFn: (Plot sales, _) => sales.year,
          measureFn: (Plot sales, _) => sales.revenueShare,
          radiusPxFn: (Plot sales, _) => sales.radius,
          data: plot2!
      ),
      charts.Series(
          id: 'Chrome',
          colorFn: (Plot sales, _) =>
          charts.MaterialPalette.purple.shadeDefault,
          domainFn: (Plot sales, _) => sales.year,
          measureFn: (Plot sales, _) => sales.revenueShare,
          radiusPxFn: (Plot sales, _) => sales.radius,
          data: plot!
      ),
      charts.Series(
          id: 'FaceBook',
          colorFn: (Plot sales, _) =>
          charts.MaterialPalette.indigo.shadeDefault,
          domainFn: (Plot sales, _) => sales.year,
          measureFn: (Plot sales, _) => sales.revenueShare,
          radiusPxFn: (Plot sales, _) => sales.radius,
          data: plot!
      ),
      charts.Series(
          id: 'Orders',
          colorFn: (Plot sales, _) =>
          charts.MaterialPalette.gray.shadeDefault,
          domainFn: (Plot sales, _) => sales.year,
          measureFn: (Plot sales, _) => sales.revenueShare,
          radiusPxFn: (Plot sales, _) => sales.radius,
          data: plot!
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
                child: charts.ScatterPlotChart(
                    series,
                    animate: true,

                    animationDuration: const Duration(seconds: 2),
                    primaryMeasureAxis: charts.BucketingAxisSpec(
                        threshold: 0.1,
                        tickProviderSpec: const charts.BucketingNumericTickProviderSpec(
                            desiredTickCount: 3)),
                    behaviors: [
                      charts.SeriesLegend(position: charts.BehaviorPosition.end),
                    ],
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
class Plot {
  final int year;
  final double revenueShare;
  final double radius;

  Plot(this.year, this.revenueShare, this.radius);
}