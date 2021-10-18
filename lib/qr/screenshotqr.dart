import 'dart:convert';
import 'dart:ui';

import 'package:covid19_vaccination/qr/image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ScreenShot extends StatefulWidget {
  @override
  _ScreenShotState createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShot> {
  GlobalKey imagekey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: imagekey,
              child: Container(
                height: 300,
                width: 300,
                child: Image.asset(
                  'assets/qrcode.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: RaisedButton(
                onPressed: () async {
                  RenderRepaintBoundary imageObject =
                      imagekey.currentContext.findRenderObject();
                  final image = await imageObject.toImage(pixelRatio: 2);
                  ByteData byteData =
                      await image.toByteData(format: ImageByteFormat.png);
                  final pngBytes = await byteData.buffer.asUint8List();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImagePage(imageBytes: pngBytes)));
                  //png bytes base64 uInt8list
                },
                child: Text('Take Image'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: RaisedButton(
                onPressed: () async {
                  RenderRepaintBoundary imageObject =
                      imagekey.currentContext.findRenderObject();
                  final image = await imageObject.toImage(pixelRatio: 2);
                  ByteData byteData =
                      await image.toByteData(format: ImageByteFormat.png);
                  final pngBytes = await byteData.buffer.asUint8List();
                  final base64String = base64Encode(pngBytes);
                  await Share.file(
                    'esys image',
                    'esys.png',
                    pngBytes,
                    'image/png',
                    text: 'My optional text',
                  );
                  //png bytes base64 uInt8list
                },
                child: Text('Share Image'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
