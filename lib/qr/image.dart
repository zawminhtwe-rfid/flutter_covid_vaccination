import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePage extends StatelessWidget {
  final imageBytes;
  const ImagePage({Key key, this.imageBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.memory(
              imageBytes,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: MaterialButton(
              onPressed: () async {
                saveImage(imageBytes);
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
        ],
      ),
    );
  }
}
