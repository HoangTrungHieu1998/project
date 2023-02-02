import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceDetectorPainter extends CustomPainter{

  final Size? absoluteImageSize;
  final List<Face>? faces;
  CameraLensDirection? cameraLensDirection;


  FaceDetectorPainter({this.absoluteImageSize, this.faces, this.cameraLensDirection});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final double scaleX = size.width/absoluteImageSize!.width;
    final double scaleY = size.height/absoluteImageSize!.height;

    final Paint paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.red;

    for(Face face in faces!){
      canvas.drawRect(
          Rect.fromLTRB(
              cameraLensDirection == CameraLensDirection.front?(absoluteImageSize!.width-face.boundingBox.right)*scaleX:face.boundingBox.left*scaleX,
              face.boundingBox.top*scaleY,
              cameraLensDirection == CameraLensDirection.front?(absoluteImageSize!.width-face.boundingBox.left)*scaleX:face.boundingBox.right*scaleX,
              face.boundingBox.bottom*scaleY
          ),
          paint);
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.absoluteImageSize != absoluteImageSize || oldDelegate.faces != faces;
  }
  
}