import 'dart:convert';

import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/general/validate.dart';
import 'package:covid19_vaccination/general/widget.dart';
import 'package:covid19_vaccination/home.dart';
import 'package:covid19_vaccination/rdt/showRDT.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class AddRDT extends StatefulWidget {
  @override
  _AddRDTState createState() => _AddRDTState();
}

class _AddRDTState extends State<AddRDT> {
  GlobalKey<FormState> formKey = GlobalKey();
  final date = TextEditingController();
  final expiredate = TextEditingController();
  DateTime exp = DateTime.now().add(const Duration(days: 3));

  List divisionlist = List();
  String _selecteddivision;
  Future getDivision() async {
    var url = Uri.parse(Config.path + "loadcombo.php");
    var response =
        await http.post(url, body: jsonEncode({'action': 'division'}));
    var jsondata = jsonDecode(response.body);
    setState(() {
      divisionlist = jsondata;
    });
  }

  List citylist = List();
  String _selectedcity;
  Future getCity() async {
    var url = Uri.parse(Config.path + "loadcombo.php");
    var response = await http.post(url,
        body: jsonEncode({'action': 'city', 'divisionid': _selecteddivision}));
    var jsondata = jsonDecode(response.body);
    print("a  ");
    print(jsondata);
    if (jsondata != null) {
      setState(() {
        citylist = jsondata;
      });
    }
  }

  List quarterlist = List();
  String _selectedquarter;
  Future getQuarter() async {
    var url = Uri.parse(Config.path + "loadcombo.php");
    var response = await http.post(url,
        body: jsonEncode({'action': 'quarter', 'cityid': _selectedcity}));
    var jsondata = jsonDecode(response.body);
    if (jsondata != null) {
      setState(() {
        quarterlist = jsondata;
      });
    }
  }

  Future save() async {
    final form = formKey.currentState;
    if (form.validate()) {
      EasyLoading.show(status: 'loading....');
      var url = Uri.parse(Config.path + "rdt.php");
      var response = await http.post(url,
          body: jsonEncode({
            'action': 'save',
            'peopleid': Config.pid,
            'date': date.text,
            'division': _selecteddivision,
            'city': _selectedcity,
            'quarter': _selectedquarter,
            'expireddate': expiredate.text,
          }));

      if (response.body == "success") {
        EasyLoading.showSuccess('Successfully saved!');
        EasyLoading.dismiss();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowRDT()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getDivision();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RDT Test'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Text("Date:"),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: date,
                  autofocus: false,
                  validator: validateNull,
                  decoration: buildInputDecoration(
                      'Enter Date', Icons.calendar_view_day),
                  onTap: () async {
                    var datedt = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    if (datedt == null) return;
                    date.text = datedt.toString().substring(0, 10);
                    DateTime exp = datedt.add(const Duration(days: 3));
                    setState(() {
                      expiredate.text = exp.toString().substring(0, 10);
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("တိုင်းဒေသကြီး"),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonFormField(
                    value: _selecteddivision,
                    hint: Text('တိုင်းဒေသကြီးရွေးချယ်ပါ'),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    validator: (value) {
                      if (value == null) {
                        return 'တိုင်းဒေသကြီးရွေးချယ်ပါ';
                      }
                      return null;
                    },
                    items: divisionlist.map(
                      (list) {
                        return DropdownMenuItem(
                          child: Text(list['d_name']),
                          value: list['d_id'].toString(),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selecteddivision = value;
                        _selectedcity = null;
                        _selectedquarter = null;
                        getCity();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("မြို့နယ်"),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonFormField(
                    value: _selectedcity,
                    hint: Text('မြို့နယ်ရွေးချယ်ပါ'),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    validator: (value) {
                      if (value == null) {
                        return 'မြို့နယ်ရွေးချယ်ပါ';
                      }
                      return null;
                    },
                    items: citylist.map(
                      (list) {
                        return DropdownMenuItem(
                          child: Text(list['c_name']),
                          value: list['c_id'].toString(),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedcity = value;
                        _selectedquarter = null;
                        getQuarter();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("ရပ်ကွက်/ကျေးရွာ"),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonFormField(
                    value: _selectedquarter,
                    hint: Text('ရပ်ကွက်/ကျေးရွာရွေးချယ်ပါ'),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    validator: (value) {
                      if (value == null) {
                        return 'ရပ်ကွက်/ကျေးရွာရွေးချယ်ပါ';
                      }
                      return null;
                    },
                    items: quarterlist.map(
                      (list) {
                        return DropdownMenuItem(
                          child: Text(list['q_name']),
                          value: list['q_id'].toString(),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedquarter = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text("Expired Date:"),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: expiredate,
                  readOnly: true,
                  autofocus: false,
                  validator: validateNull,
                  decoration: buildInputDecoration(
                      'Enter Date', Icons.calendar_view_day),
                  // onTap: () async {
                  //   var datedt = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime(1900),
                  //       lastDate: DateTime(2100));
                  //   if (datedt == null) return;
                  //   expiredate.text = datedt.toString().substring(0, 10);
                  // },
                ),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: () {
                    save();
                  },
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 45,
                  minWidth: 600,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                // longButtons('login'.tr(), Login),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
