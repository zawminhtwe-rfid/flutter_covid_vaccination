import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  PickedFile imageFile;
  ProfilePhoto({this.imageFile});

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  Future savephoto() async {
    EasyLoading.show(status: 'loading...');
    var uri = Uri.parse(Config.path + "profilephoto.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['action'] = "changepic";
    request.fields['aid'] = Config.pid;
    //request.fields['path'] = widget.imageFile.path;
    var pic = await http.MultipartFile.fromPath("file", widget.imageFile.path);
    request.files.add(pic);
    var response = await request.send();

    http.Response.fromStream(response).then((res) {
      if (response.statusCode == 200) {
        if (res.body == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Successfully save.'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.purple[300],
            ),
          );
          EasyLoading.dismiss();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        } else {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Fail save.'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.purple[300],
            ),
          );
        }
      }
      return res.body;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Photo'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                savephoto();
              })
        ],

        // backgroundColor: Colors.purple[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          uploadimage(),
        ],
      ),
    );
  }

  Widget uploadimage() {
    return Center(
      child: Stack(children: [
        CircleAvatar(
          radius: 200.0,
          backgroundImage: FileImage(File(widget.imageFile.path)),
        ),
      ]),
    );
  }
}
