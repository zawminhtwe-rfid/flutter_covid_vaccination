import 'dart:convert';
import 'dart:io';
import 'package:covid19_vaccination/home.dart';
import 'package:covid19_vaccination/profile/profileedit.dart';
import 'package:covid19_vaccination/profile/profilephpto.dart';
import 'package:http/http.dart' as http;
import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/model/profilemodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  PickedFile _imageFile;
  File imageFile;
  final ImagePicker picker = ImagePicker();
  ProfileModel _profile;

  Future chooseImage(ImageSource source) async {
    var img = await picker.getImage(source: source);
    print("print Image");
    print(img);
    setState(() {
      imageFile = File(img.path);
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePhoto(
                  imageFile: img,
                )));
  }

  Future<ProfileModel> showProfile() async {
    var url = Uri.parse(Config.path + "profile.php");
    var response = await http.post(url,
        body: jsonEncode({"action": "showprofile", "pid": Config.pid}));
    // print(Config.finalid);

    if (response.statusCode == 200) {
      var jsonbody = response.body;
      ProfileModel res = ProfileModel.fromJson(json.decode(jsonbody));
      return res;
    }
  }

  Widget build(BuildContext context) {
    Widget Show() {
      return FutureBuilder(
          future: showProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ProfileModel list = snapshot.data;
              var img = '';
              var initialname = list.data.name[0].toUpperCase();
              if (list.data.image != null) {
                img = list.data.image;
                initialname = '';
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Stack(children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(img),
                        child: Text(
                          initialname,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        radius: 60.0,
                      ),
                      Positioned(
                        bottom: 8.0,
                        right: 8.0,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottonSheet()),
                            );
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.purpleAccent[100],
                            size: 28.0,
                          ),
                        ),
                      ),
                    ])),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileEdit(
                                        list: list,
                                      )));
                        },
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: SizedBox(
                          width: 100.0,
                          child: Text(
                            'Edit Profile',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        height: 45,
                        minWidth: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'Name:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(list.data.name),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'Father Name:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(list.data.fathername),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'Date Of Birth:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    // _patch == null ? Container() : Text(_patch.name),
                    list.data.dob == null ? Container() : Text(list.data.dob),

                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'Age:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    //Text(list.data.phoneno),
                    // _patch == null ? Container() : Text(_patch.name),
                    list.data.age == null ? Container() : Text(list.data.age),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'Gender:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Text(list.data.address),
                    list.data.gender == null
                        ? Container()
                        : Text(list.data.gender),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'Phone Number:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Text(list.data.address),
                    list.data.phno == null ? Container() : Text(list.data.phno),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Text(list.data.address),
                    list.data.email == null
                        ? Container()
                        : Text(list.data.email),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'NRC Number:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),

                    list.data.nrcDivisionCode == null
                        ? Container()
                        : Text(list.data.nrcDivisionCode +
                            "/" +
                            list.data.nrcCityCode +
                            " (နိုင်) " +
                            list.data.nrcno),

                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'Division:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),

                    list.data.divisionname == null
                        ? Container()
                        : Text(list.data.divisionname),

                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'City:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),

                    list.data.cityname == null
                        ? Container()
                        : Text(list.data.cityname),

                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                        height: 30.0,
                        child: Text(
                          'Quarter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),

                    list.data.quartername == null
                        ? Container()
                        : Text(list.data.quartername),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              //img(),
              SizedBox(
                height: 20,
              ),
              Show(),
            ],
          ),
        ));
  }

  Widget uploadimage() {
    return Center(
      child: Stack(children: [
        CircleAvatar(
          radius: 60.0,
          backgroundImage: imageFile == null
              ? AssetImage('images/avater.jpg')
              : FileImage(File(imageFile.path)),
        ),
        Positioned(
          bottom: 5.0,
          right: 5.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottonSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        )
      ]),
    );
  }

  Widget bottonSheet() {
    return Container(
      height: 230.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose Option",
            style: TextStyle(
              color: Colors.purpleAccent,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton.icon(
                  onPressed: () {
                    chooseImage(ImageSource.camera);
                    //Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.camera,
                    color: Colors.purpleAccent,
                  ),
                  label: Text("Camera"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton.icon(
                  onPressed: () {
                    chooseImage(ImageSource.gallery);
                    //Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.purpleAccent,
                  ),
                  label: Text("Gallery"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton.icon(
                  onPressed: () {
                    //print(id);
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.purpleAccent,
                  ),
                  label: Text("Cancel"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
