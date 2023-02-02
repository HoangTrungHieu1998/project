import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class TextDetectDecoration extends Decoration {
  final Size _originalImageSize;
  final List<RecognisedText> _texts;
  const TextDetectDecoration(List<RecognisedText> texts, Size originalImageSize)
      : _texts = texts,
        _originalImageSize = originalImageSize;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TextDetectPainter(_texts, _originalImageSize);
  }
}

class _TextDetectPainter extends BoxPainter {
  final List<RecognisedText> _texts;
  final Size _originalImageSize;
  _TextDetectPainter(texts, originalImageSize)
      : _texts = texts,
        _originalImageSize = originalImageSize;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    final _heightRatio = _originalImageSize.height / configuration.size!.height;
    final _widthRatio = _originalImageSize.width / configuration.size!.width;
    for (var text in _texts) {
      final _rect = Rect.fromLTRB(
          offset.dx + text.blocks.first.rect.left / _widthRatio,
          offset.dy + text.blocks.first.rect.top / _heightRatio,
          offset.dx + text.blocks.first.rect.right / _widthRatio,
          offset.dy + text.blocks.first.rect.bottom / _heightRatio);
      canvas.drawRect(_rect, paint);
    }
    canvas.restore();
  }
}
