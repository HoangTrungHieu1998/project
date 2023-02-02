import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:machine_learning/package_test/detect.dart';
import 'package:machine_learning/package_test/face_detector_painter.dart';

class FaceDetect extends StatefulWidget {
  const FaceDetect({Key? key}) : super(key: key);

  @override
  _FaceDetectState createState() => _FaceDetectState();
}

class _FaceDetectState extends State<FaceDetect> {

  bool isWorking = false;
  CameraController? cameraController;
  FaceDetector? faceDetector;
  Size? size;
  List<Face>? faceList;
  CameraDescription? cameraDescription;
  CameraLensDirection? cameraLensDirection = CameraLensDirection.front;

  initCamera()async{
    cameraDescription = await Detect.getCamera(cameraLensDirection!);
    cameraController = CameraController(cameraDescription!,ResolutionPreset.medium);
    faceDetector = GoogleMlKit.vision.faceDetector(const FaceDetectorOptions(
      enableClassification: true,
      minFaceSize: 0.1,
      mode: FaceDetectorMode.fast
    ));
    await cameraController!.initialize().then((value){
      if(!mounted){
        return;
      }
      cameraController!.startImageStream((image)=>{
        if(!isWorking){
          isWorking = true,
          performDetectionOnStreamFrames(image),
        }
      });
    });
  }

  dynamic scanResult;
  performDetectionOnStreamFrames(CameraImage cameraImage)async{
    Detect.detect(
        image: cameraImage,
        detectImage: faceDetector!.processImage,
        imageRotation: cameraDescription!.sensorOrientation
    ).then((value) {
      setState(() {
        scanResult = value;
      });
    }).whenComplete((){
      isWorking = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController!.dispose();
    faceDetector!.close();
  }

  Widget buildResult(){
    if(scanResult == null || cameraController == null || !cameraController!.value.isInitialized){
      return const Text("");
    }
    final Size imageSize = Size(cameraController!.value.previewSize!.width, cameraController!.value.previewSize!.width);
    CustomPainter painter = FaceDetectorPainter(absoluteImageSize: imageSize,cameraLensDirection: cameraLensDirection,faces: scanResult);
    return CustomPaint(
      painter: painter
    );
  }

  toggleCameraToFrontOrBack()async{
    if(cameraLensDirection == CameraLensDirection.back){
      cameraLensDirection == CameraLensDirection.front;
    }else{
      cameraLensDirection == CameraLensDirection.back;
    }
    await cameraController!.stopImageStream();
    await cameraController!.dispose();
    setState(() {
      cameraController = null;
    });
    initCamera();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> stackWidgetChildren =[];
    size = MediaQuery.of(context).size;

    if(cameraController !=null){
      stackWidgetChildren.add(
        Positioned(
            top: 0,
            left: 0,
            width: size!.width,
            height: size!.height-250,
            child: Container(
              child: cameraController!.value.isInitialized?
              AspectRatio(
                  aspectRatio: cameraController!.value.aspectRatio,
                  child: CameraPreview(cameraController!),
              ):
              Container(),
            )
        )
      );
    }
    
    stackWidgetChildren.add(
        Positioned(
            top: size!.height-250,
            left: 0,
            width: size!.width,
            height: 250,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: (){
                        toggleCameraToFrontOrBack();
                      },
                      icon: const Icon(Icons.cached,color: Colors.white,),
                      iconSize: 50,
                      color: Colors.black,
                  )
                ],
              )
            )
        )
    );

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 0),
        color: Colors.black,
        child: Stack(
          children: stackWidgetChildren,
        ),
      ),
    );
  }
}
