import 'dart:convert';

import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/qr/code.dart';
import 'package:covid19_vaccination/qr/qr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowQr extends StatefulWidget {
  @override
  _ShowQrState createState() => _ShowQrState();
}

class _ShowQrState extends State<ShowQr> {
  Future show() async {
    var url = Uri.parse(Config.path + 'showqr.php');
    var response = await http.post(url,
        body: jsonEncode({'action': 'show', 'pid': Config.pid}));
    var jsonbody = response.body;
    var jsonData = json.decode(jsonbody);

    return jsonDecode(response.body);
  }

  @override
  @override
  void initState() {
    super.initState();
    show();
  }

  Widget build(BuildContext context) {
    Widget showqr() {
      return FutureBuilder(
          future: show(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      var nameIntial = list[index]['co_time'][0].toUpperCase();
                      var image = "";
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Config.qrpath = list[index]['co_qrimage'];
                              Config.qrcode = list[index]['co_qrcode'];
                              print(list[index]['co_confirm']);
                              if (list[index]['co_confirm'] == "1") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QrPage()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Code(aid: list[index]['co_id'])));
                              }
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightGreen,
                              backgroundImage: NetworkImage(image),
                              radius: 35.0,
                              child: Text(
                                nameIntial,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.arrow_right_rounded,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              list[index]['co_time'] + " dose",
                              style: TextStyle(color: Colors.purpleAccent),
                            ),
                            subtitle: Text(list[index]['co_date'],
                                style: TextStyle(color: Colors.white)),
                          ),
                          Divider(
                            height: 10.0,
                            color: Colors.white24,
                          )
                        ],
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Show QR'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: showqr(),
    );
  }
}
