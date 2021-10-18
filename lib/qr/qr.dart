import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/general/widget.dart';
import 'package:covid19_vaccination/qr/image.dart';
import 'package:covid19_vaccination/qr/screenshotqr.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrPage extends StatefulWidget {
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  GlobalKey imagekey = GlobalKey();

  @override
  var image = "";

  @override
  void initState() {
    super.initState();
    // image = Config.path1 + "lib/qrimage/" + Config.qrpath;
    image = Config.path + "upload/" + Config.qrpath;
    print(image);
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'qrimage_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }

  final controller = ScreenshotController();

  Widget buildimage() {
    return Center(
      child: SizedBox(
        height: 300,
        width: 300,
        child: QrImage(
          data: Config.qrcode,
          version: QrVersions.auto,
          size: 200.0,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget build(BuildContext context) => Screenshot(
        controller: controller,
        child: Scaffold(
            appBar: AppBar(
              title: Text('QR Code'),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                    child: Center(
                        child: Text(
                      Config.name,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  buildimage(),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        final image =
                            await controller.captureFromWidget(buildimage());

                        await saveImage(image);
                        showSnackBar(context, 'Image Save gallery.');
                      },
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: SizedBox(
                        width: 100.0,
                        child: Text(
                          'Save QR Code',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: 45,
                      minWidth: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        // RenderRepaintBoundary imageObject =
                        //     imagekey.currentContext.findRenderObject();
                        // final image = await imageObject.toImage(pixelRatio: 2);
                        // ByteData byteData = await image.toByteData(
                        //     format: ui.ImageByteFormat.png);
                        // final pngBytes = await byteData.buffer.asUint8List();
                        // final base64String = base64Encode(pngBytes);

                        final image =
                            await controller.captureFromWidget(buildimage());

                        await Share.file(
                          'COVID19 Vaccination image',
                          'COVID19_Vaccination.png',
                          image,
                          'image/png',
                          text: 'My optional text',
                        );
                        //png bytes base64 uInt8list
                      },
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: SizedBox(
                        width: 100.0,
                        child: Text(
                          'Share QR Code',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: 45,
                      minWidth: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ],
              ),
            )),
      );
}
