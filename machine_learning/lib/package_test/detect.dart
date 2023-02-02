import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class Detect{
  Detect._();

  static Future<CameraDescription> getCamera(CameraLensDirection cameraLensDirection) async{
    return await availableCameras().then((value) =>
        value.firstWhere((element) => element.lensDirection == cameraLensDirection
        ));
  }

  static InputImageRotation rotationIntToImageRotation(int rotation){
    switch(rotation){
      case 0:
        return InputImageRotation.Rotation_0deg;
      case 90:
        return InputImageRotation.Rotation_90deg;
      case 180:
        return InputImageRotation.Rotation_180deg;
      default:
        assert(rotation == 270);
        return InputImageRotation.Rotation_270deg;

    }
  }

  static Uint8List concatenatePlanes(List<Plane> planes){
    final WriteBuffer writeBuffer = WriteBuffer();
    for(Plane plane in planes){
      writeBuffer.putUint8List(plane.bytes);
    }
    return writeBuffer.done().buffer.asUint8List();
  }

  static InputImageData buildMetaData(CameraImage image, InputImageRotation rotation){
    return InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        imageRotation: rotation,
        inputImageFormat: InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21,
        planeData: image.planes.map(
            (Plane plane){
              return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  width: plane.width,
                  height: plane.height
              );
            }
        ).toList()
    );
  }

  static Future<dynamic> detect({required CameraImage image, required Future<dynamic> Function(InputImage image) detectImage,required int imageRotation}){
    return detectImage(
      InputImage.fromBytes(
          bytes: concatenatePlanes(image.planes),
          inputImageData: buildMetaData(image, rotationIntToImageRotation(imageRotation)))
    );
  }

}