import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter{
  final List<String> x;
  final List<double> y;
  final double min, max;

  ChartPainter(this.x, this.y, this.min, this.max);

  final Color backgroundColor = Colors.black;

  final labelStyle = const TextStyle(color: Colors.white38, fontSize: 14);
  final xLabelStyle = const TextStyle(color: Colors.white38, fontSize: 16,fontWeight: FontWeight.bold);

  static double border = 10.0;
  static double radius = 5.0;

  final linePaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.stroke
  ..strokeWidth = 1.0;

  final dotPaintFill = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill
    ..strokeWidth = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color=Colors.black);

    //compute the drawable chart width and height
    final drawableHeight = size.height -2.0 * border;
    final drawableWidth = size.width -2.0 * border;
    final hd = drawableHeight / 5.0;
    final wd = drawableWidth / x.length.toDouble();
    final height = hd *3.0;
    final width = drawableWidth;

    //escape if values are invalid
    if(height <=0 || width <=0) return;
    if(max - min < 1.0e-6) return;

    final hr = height / (max - min);
    final left = border;
    final top = border;
    final c = Offset(left + wd / 2.0, top + height / 2.0);
    //_drawOutline(canvas,c,wd,height);

    final points = _computePoints(c,wd,height,hr);
    final path = _computePath(points);
    final labels = _computeLabels();

    // draw data points and labels
    canvas.drawPath(path, linePaint);
    _drawDataPoints(canvas,points,dotPaintFill);
    _drawLabels(canvas,labels,points,wd,top);

    // draw x labels
    final c1 = Offset(c.dx,top +4.5 *hd);
    _drawXLabels(canvas,c1,wd);
  }

  void _drawXLabels(Canvas canvas, Offset c, double wd) {
    for (var element in x) {
      drawTextCentered(canvas, c, element, labelStyle, wd);
      c += Offset(wd,0);
    }
  }

  void _drawLabels(Canvas canvas, List<String> labels, List<Offset> points, double wd, double top) {
    var i =0;
    for (var element in labels) {
      final dp = points[i];
      final dy = (dp.dy - 15.0) < top ? 15.0 : -15.0;
      final ly = dp + Offset(0,dy);
      drawTextCentered(canvas, ly, element, labelStyle, wd);
      i++;
    }
  }

  void _drawDataPoints(Canvas canvas, List<Offset> points, Paint dotPaintFill) {
    for(var element in points){
      canvas.drawCircle(element, radius, dotPaintFill);
      canvas.drawCircle(element, radius, linePaint);
    }
  }

  Path _computePath(List<Offset> points){
    final path = Path();
    for(var i =0; i<points.length; i++){
      final p = points[i];
      if(i==0){
        path.moveTo(p.dx, p.dy);
      }else{
        path.lineTo(p.dx, p.dy);
      }
    }
    return path;
  }

  List<Offset> _computePoints(Offset c, double wd, double height, double hr){
    List<Offset> points = [];
    for (var element in y) {
      final yy = height - (element - min) * hr;
      final dp = Offset(c.dx, c.dy - height / 2.0 + yy);
      points.add(dp);
      c += Offset(wd,0);
    }
    return points;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  final Paint outlinePaint = Paint()
  ..strokeWidth = 1.0
  ..style = PaintingStyle.stroke
  ..color = Colors.white;

  void _drawOutline(Canvas canvas, Offset c, double wd, double height) {
    for (var element in y) {
      final rect = Rect.fromCenter(center: c, width: wd, height: height);
      canvas.drawRect(rect, outlinePaint);
      c += Offset(wd,0);
    }
  }

  List<String> _computeLabels(){
    return y.map((e) => e.toStringAsFixed(1)).toList();
  }

  TextPainter measureText(String label, TextStyle labelStyle, double maxWidth, TextAlign align) {
    final span = TextSpan(text: label, style: labelStyle);
    final tp = TextPainter(text: span,textAlign: align,textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0,maxWidth: maxWidth);
    return tp;
  }

  Size drawTextCentered(Canvas canvas, Offset c, String label, TextStyle labelStyle, double wd) {
    final tp = measureText(label,labelStyle,wd,TextAlign.center);
    final offset = c + Offset(-tp.width / 2.0, -tp.height /2.0 );
    tp.paint(canvas, offset);
    return tp.size;
  }


}







