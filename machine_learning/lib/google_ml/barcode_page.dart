import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class BarcodeDetectDecoration extends Decoration {
  final Size _originalImageSize;
  final List<Barcode> _barcodes;

  const BarcodeDetectDecoration(List<Barcode> barcodes, Size originalImageSize)
      : _barcodes = barcodes,
        _originalImageSize = originalImageSize;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _BarcodeDetectPainter(_barcodes, _originalImageSize);
  }
}

class _BarcodeDetectPainter extends BoxPainter {
  final List<Barcode> _barcodes;
  final Size _originalImageSize;
  _BarcodeDetectPainter(barcodes, originalImageSize)
      : _barcodes = barcodes,
        _originalImageSize = originalImageSize;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    final _heightRatio = _originalImageSize.height / configuration.size!.height;
    final _widthRatio = _originalImageSize.width / configuration.size!.width;
    for (var barcode in _barcodes) {
      final _rect = Rect.fromLTRB(
          offset.dx + barcode.value.boundingBox!.left / _widthRatio,
          offset.dy + barcode.value.boundingBox!.top / _heightRatio,
          offset.dx + barcode.value.boundingBox!.right / _widthRatio,
          offset.dy + barcode.value.boundingBox!.bottom / _heightRatio);
      canvas.drawRect(_rect, paint);
    }
    canvas.restore();
  }
}