import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_learning/google_ml/text_detect_page.dart';

import 'barcode_page.dart';
import 'face_page.dart';
import 'lable_page.dart';
import 'ml_home.dart';

class MLDetail extends StatefulWidget {
  final PickedFile? file;
  final String? scanner;

  const MLDetail({Key? key,this.file,this.scanner}) : super(key: key);

  @override
  _MLDetailState createState() => _MLDetailState();
}

class _MLDetailState extends State<MLDetail> {

  Stream? sub;
  StreamSubscription<dynamic>? subscription;
  List<RecognisedText> currentTextLabels = <RecognisedText>[];
  List<Barcode> currentBarcodeLabels = <Barcode>[];
  List<ImageLabel> currentLabelLabels = <ImageLabel>[];
  List<Face> currentFaceLabels = <Face>[];
  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  final faceDetector = GoogleMlKit.vision.faceDetector();
  final imageLabeler = GoogleMlKit.vision.imageLabeler();
  final poseDetector = GoogleMlKit.vision.poseDetector();
  final textDetector = GoogleMlKit.vision.textDetector();

  File? storedImage;
  InputImage? inputImage;

  void analyzeLabels() async {
    try {
      var currentLabels;
      if (widget.scanner == TEXT_SCANNER) {
        currentLabels = await textDetector.processImage(inputImage!);
        if (this.mounted) {
          setState(() {
            currentTextLabels = currentLabels;
          });
        }
      } else if (widget.scanner == BARCODE_SCANNER) {
        currentLabels = await barcodeScanner.processImage(inputImage!);
        if (this.mounted) {
          setState(() {
            currentBarcodeLabels = currentLabels;
          });
        }
      } else if (widget.scanner == LABEL_SCANNER) {
        currentLabels = await imageLabeler.processImage(inputImage!);
        if (this.mounted) {
          setState(() {
            currentLabelLabels = currentLabels;
          });
        }
      } else if (widget.scanner == FACE_SCANNER) {
        currentLabels = await faceDetector.processImage(inputImage!);
        if (this.mounted) {
          setState(() {
            currentFaceLabels = currentLabels;
          });
        }
      }
    } catch (e) {
      print("MyEx: " + e.toString());
    }
  }

  Future<Size> _getImageSize(Image image) {
    Completer<Size> completer = Completer<Size>();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _)=>completer.complete(
          Size(info.image.width.toDouble(), info.image.height.toDouble())))
    );
    return completer.future;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storedImage = File(widget.file!.path);
    inputImage = InputImage.fromFilePath(widget.file!.path);
    sub = const Stream.empty();
    subscription = sub!.listen((_) => _getImageSize)..onDone(analyzeLabels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.scanner!),
        ),
        body: Column(
          children: <Widget>[
            buildImage(context),
            widget.scanner == TEXT_SCANNER
                ? buildTextList(currentTextLabels)
                : widget.scanner == BARCODE_SCANNER
                ? buildBarcodeList<Barcode>(currentBarcodeLabels)
                : widget.scanner == FACE_SCANNER
                ? buildBarcodeList<Face>(currentFaceLabels)
                : buildBarcodeList<ImageLabel>(currentLabelLabels)
          ],
        ));
  }

  Widget buildImage(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Center(
            child: widget.file == null
                ? const Text('No Image')
                : FutureBuilder<Size>(
              future: _getImageSize(
                  Image.file(storedImage!, fit: BoxFit.fitWidth)),
              builder:
                  (BuildContext context, AsyncSnapshot<Size> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      foregroundDecoration: (widget.scanner ==
                          TEXT_SCANNER)
                          ? TextDetectDecoration(
                          currentTextLabels, snapshot.data!)
                          : (widget.scanner == FACE_SCANNER)
                          ? FaceDetectDecoration(
                          currentFaceLabels, snapshot.data!)
                          : (widget.scanner == BARCODE_SCANNER)
                          ? BarcodeDetectDecoration(
                          currentBarcodeLabels,
                          snapshot.data!)
                          : LabelDetectDecoration(
                          currentLabelLabels, snapshot.data!),
                      child:
                      Image.file(storedImage!, fit: BoxFit.fitWidth));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          )),
    );
  }

  Widget buildBarcodeList<T>(List<T> barcodes) {
    if (barcodes.length == 0) {
      return Expanded(
        flex: 1,
        child: Center(
          child: Text('Nothing detected',
              style: Theme.of(context).textTheme.subtitle1),
        ),
      );
    }
    return Expanded(
      flex: 1,
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: barcodes.length,
            itemBuilder: (context, i) {
              var text;

              final barcode = barcodes[i];
              switch (widget.scanner) {
                case BARCODE_SCANNER:
                  Barcode res = barcode as Barcode;
                  text = "Raw Value: ${res.value.rawValue}";
                  break;
                case FACE_SCANNER:
                  Face res = barcode as Face;
                  text =
                  "Raw Value: ${res.smilingProbability},${res.trackingId},${res.leftEyeOpenProbability}";
                  break;
                case LABEL_SCANNER:
                  ImageLabel res = barcode as ImageLabel;
                  text = "Raw Value: ${res.label}";
                  break;
              }

              return _buildTextRow(text);
            }),
      ),
    );
  }

  Widget buildTextList(List<RecognisedText> texts) {
    if (texts.length == 0) {
      return Expanded(
          flex: 1,
          child: Center(
            child: Text('No text detected',
                style: Theme.of(context).textTheme.subtitle1),
          ));
    }
    return Expanded(
      flex: 1,
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: texts.length,
            itemBuilder: (context, i) {
              return _buildTextRow(texts[i].text);
            }),
      ),
    );
  }

  Widget _buildTextRow(text) {
    return ListTile(
      title: Text(
        "$text",
      ),
      dense: true,
    );
  }
}

