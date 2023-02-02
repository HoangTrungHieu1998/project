import 'package:flutter/material.dart';

import 'chart_painter.dart';

class Score{
  late double value;
  late DateTime time;

  Score(this.value, this.time);
}

class ProgressChart extends StatefulWidget {
  final List<Score>? scores;
  const ProgressChart({Key? key,this.scores}) : super(key: key);

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

const WeekDays =["","Mon","Tue","Wed","Thu","Fri","Sat","Sun"];

class _ProgressChartState extends State<ProgressChart> {
  late double _min,_max;
  late List<double> _Y;
  late List<String> _X;

  @override
  void initState() {
    // TODO: implement initState
    var min = double.maxFinite;
    var max = -double.maxFinite;
    for (var element in widget.scores!) {
      min = min > element.value ? element.value : min;
      max = max < element.value ? element.value :max;
    }
    setState(() {
      _min = min;
      _max = max;
      _Y = widget.scores!.map((e) => e.value).toList();
      _X = widget.scores!.map((e) => "${WeekDays[e.time.weekday]}\n${e.time.day}").toList();
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ChartPainter(_X,_Y,_min,_max),
      child: Container(),
    );
  }
}


