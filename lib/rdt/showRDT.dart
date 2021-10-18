import 'dart:convert';

import 'package:covid19_vaccination/RDT/addRDT.dart';
import 'package:covid19_vaccination/RDT/editRDT.dart';
import 'package:covid19_vaccination/RDT/qrRDTpage.dart';
import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/general/widget.dart';
import 'package:covid19_vaccination/qr/code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ShowRDT extends StatefulWidget {
  @override
  _ShowRDTState createState() => _ShowRDTState();
}

class _ShowRDTState extends State<ShowRDT> {
  Future show() async {
    var url = Uri.parse(Config.path + 'rdt.php');
    var response = await http.post(url,
        body: jsonEncode({'action': 'show', 'pid': Config.pid}));
    var jsonbody = response.body;
    var jsonData = json.decode(jsonbody);

    return jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
    show();
  }

  @override
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
                      var nameIntial = list[index]['co_id'];
                      var image = "";
                      var exp = DateTime.parse(list[index]['co_expdate']);
                      var now = DateTime.now().compareTo(exp);
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Config.qrrdt = list[index]['co_qrcode'];
                              Config.name = list[index]['p_name'];

                              if (list[index]['co_confirm'] == "1" &&
                                  now.toString() == "-1") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QrRDTPage(
                                              qrcode: list[index]['co_qrcode'],
                                            )));
                              } else {
                                showAlertDialog(context, "Alert",
                                    "Your Information is Denied or expired date");
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
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => bottonSheet(
                                          list[index]['co_id'], list, index)),
                                    );
                                  },
                                  child: Icon(
                                    Icons.more,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              "RDT date: " + list[index]['co_date'],
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            subtitle: now.toString() == "1"
                                ? Text('Expired',
                                    style: TextStyle(color: Colors.red))
                                : Text(
                                    "Expire date: " + list[index]['co_expdate'],
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
        title: Text('Show RDT QR'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: showqr(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddRDT())),
              }),
    );
  }

  void deleteFun(String id) async {
    confrimDialog(context, id);
  }

  confrimDialog(BuildContext context, String id) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Question?'),
          content: Text("Are You Sure to Delete ?"),
          actions: <Widget>[
            FlatButton(
              child: Text("YES"),
              onPressed: () async {
                var url = Uri.parse(Config.path + 'rdt.php');
                var response = await http.post(url,
                    body: jsonEncode({'id': id, 'action': 'delete'}));

                Navigator.of(context).pop();
                print(response.body);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('delete data successful.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.purple[300],
                  ),
                );
                setState(() {
                  //showFun();
                });
              },
            ),
            FlatButton(
              child: Text("NO"),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                //Put your code here which you want to execute on Cancel button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget bottonSheet(String id, List list, int index) {
    return Container(
      height: 220.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Edit & Delete",
            style: TextStyle(
              color: Colors.black,
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
                    //print('edit');
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditRDT(
                                  list: list,
                                  index: index,
                                ),
                            fullscreenDialog: true));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  label: Text(
                    "Edit",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton.icon(
                  onPressed: () {
                    //print(id);
                    setState(() {
                      deleteFun(id);
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.blue,
                  ),
                  label: Text(
                    "Delete",
                    style: TextStyle(color: Colors.black),
                  ),
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
                    color: Colors.blue,
                  ),
                  label: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
