import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceDetectDecoration extends Decoration {
  final Size _originalImageSize;
  final List<Face> _faces;
  const FaceDetectDecoration(List<Face> faces, Size originalImageSize)
      : _faces = faces,
        _originalImageSize = originalImageSize;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FaceDetectPainter(_faces, _originalImageSize);
  }
}

class _FaceDetectPainter extends BoxPainter {
  final List<Face> _faces;
  final Size _originalImageSize;
  _FaceDetectPainter(faces, originalImageSize)
      : _faces = faces,
        _originalImageSize = originalImageSize;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    final _heightRatio = _originalImageSize.height / configuration.size!.height;
    final _widthRatio = _originalImageSize.width / configuration.size!.width;
    for (var face in _faces) {
      final _rect = Rect.fromLTRB(
          offset.dx + face.boundingBox.left / _widthRatio,
          offset.dy + face.boundingBox.top / _heightRatio,
          offset.dx + face.boundingBox.right / _widthRatio,
          offset.dy + face.boundingBox.bottom / _heightRatio);
      canvas.drawRect(_rect, paint);
    }
    canvas.restore();
  }
}
