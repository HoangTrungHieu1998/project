import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class LabelDetectDecoration extends Decoration {
  final Size _originalImageSize;
  final List<ImageLabel> _labels;
  const LabelDetectDecoration(List<ImageLabel> labels, Size originalImageSize)
      : _labels = labels,
        _originalImageSize = originalImageSize;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _LabelDetectPainter(_labels, _originalImageSize);
  }
}

class _LabelDetectPainter extends BoxPainter {
  final List<ImageLabel> _labels;
  final Size _originalImageSize;
  _LabelDetectPainter(labels, originalImageSize)
      : _labels = labels,
        _originalImageSize = originalImageSize;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    final _heightRatio = _originalImageSize.height / configuration.size!.height;
    final _widthRatio = _originalImageSize.width / configuration.size!.width;
    for (var label in _labels) {
      final _rect = Rect.fromLTRB(
          offset.dx + label.confidence / _widthRatio,
          offset.dy + label.confidence / _heightRatio,
          offset.dx + label.confidence / _widthRatio,
          offset.dy + label.confidence / _heightRatio);
      canvas.drawRect(_rect, paint);
    }
    canvas.restore();
  }
}