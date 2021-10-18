import 'dart:convert';

import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/general/widget.dart';
import 'package:covid19_vaccination/login.dart';
import 'package:covid19_vaccination/profile/profile.dart';
import 'package:covid19_vaccination/qr/code.dart';
import 'package:covid19_vaccination/qr/qr.dart';
import 'package:covid19_vaccination/qr/showqr.dart';
import 'package:covid19_vaccination/rdt/showrdt.dart';
import 'package:covid19_vaccination/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getsharePreference() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainid = sharedPreferences.getString('pid');
    var obtpsw = sharedPreferences.getString('psw');
    var obtname = sharedPreferences.getString('name');
    var obtusername = sharedPreferences.getString('username');
    setState(() {
      Config.pid = obtainid;
      Config.psw = obtpsw;
      Config.name = obtname;
      Config.username = obtusername;
    });
    print(Config.pid);
    // print(Config.psw);
  }

  Container ContanctListCircle(String imageVal, String heading) {
    var nameIntial = heading[0].toUpperCase();
    if (imageVal.length > 0) {
      nameIntial = "";
    }
    return Container(
      width: 100.0,
      child: Center(
        child: Card(
          color: Colors.transparent,
          child: Wrap(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                backgroundImage: NetworkImage(imageVal),
                radius: 50.0,
                child: Text(
                  nameIntial,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    heading,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container MyArticles(String imageVal, String heading, String subHeading) {
    return Container(
      width: 160.0,
      child: Card(
        child: Column(
          children: [
            SizedBox(
                height: 60.0,
                width: 50.0,
                child: Image.asset(
                  'assets/img1.jpg',
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 5.0,
            ),
            ListTile(
              title: Text(
                heading,
                style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  @override
  void initState() {
    super.initState();
    getsharePreference();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('back');
        return showAlertDialog(context, "Information", "Please first logout");
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Icon(Icons.home),
          title: Text('Home'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 200.0,
              width: double.infinity,
              child: Carousel(
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.lightGreen,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.transparent,
                dotVerticalPadding: 5.0,
                dotPosition: DotPosition.bottomRight,
                images: [
                  InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/img1.jpg',
                        fit: BoxFit.cover,
                      )),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/img2.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/img3.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/img4.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            SizedBox(
              height: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      child: ContanctListCircle("", "PROFILE")),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Setting()));
                      },
                      child: ContanctListCircle("", "SETTING")),
                ],
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            SizedBox(
              height: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ShowQr()));
                      },
                      child: ContanctListCircle("", "QR CODE")),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ShowRDT()));
                      },
                      child: ContanctListCircle("", "QR RDT")),
                ],
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            SizedBox(
              height: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                        if (Config.pid != null) {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove('pid');
                          sharedPreferences.remove("psw");
                          sharedPreferences.remove("name");

                          setState(() {
                            Config.pid = null;
                            Config.psw = null;
                            Config.name = null;
                          });
                          showSnackBar(context, 'Logout Successful');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        } else {
                          showAlertDialog(
                              context, "Alert", "Please First Login");
                        }
                      },
                      child: ContanctListCircle("", "LOGOUT")),
                ],
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
          ],
        ),
      ),
    );
  }
}
