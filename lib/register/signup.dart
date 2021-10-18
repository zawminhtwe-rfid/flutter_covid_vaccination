import 'dart:convert';
import 'package:covid19_vaccination/login.dart';
import 'package:http/http.dart' as http;
import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/general/validate.dart';
import 'package:covid19_vaccination/general/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey();
  final name = TextEditingController();
  final fathername = TextEditingController();
  final dob = TextEditingController();
  final age = TextEditingController();
  final phno = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final nrcno = TextEditingController();

  List<String> _genderlist = ["Male", "Female"]; // Option 2
  String _selectgender;

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

  List nrccodelist = List();
  String _selectednrccode;
  Future getNRCcode() async {
    var url = Uri.parse(Config.path + "loadcombo.php");
    var response =
        await http.post(url, body: jsonEncode({'action': 'division'}));
    var jsondata = jsonDecode(response.body);
    if (jsondata != null) {
      setState(() {
        nrccodelist = jsondata;
      });
    }
  }

  List nrccitylist = List();
  String _selectednrccity;
  Future getNRCCity() async {
    EasyLoading.show(status: 'loading....');
    var url = Uri.parse(Config.path + "loadcombo.php");
    var response = await http.post(url,
        body: jsonEncode({'action': 'city', 'divisionid': _selectednrccode}));
    var jsondata = jsonDecode(response.body);
    if (jsondata != null) {
      setState(() {
        nrccitylist = jsondata;
      });
    }
    EasyLoading.dismiss();
  }

  static final List item = [
    'နိုင်',
    'ဧည့်',
    'သာ',
    'ဝန်',
  ];
  String value = item.first;

  Future save() async {
    final form = formKey.currentState;
    if (form.validate()) {
      EasyLoading.show(status: 'loading....');
      var url = Uri.parse(Config.path + "peopleregister.php");
      var response = await http.post(url,
          body: jsonEncode({
            'action': 'save',
            'name': name.text,
            'fathername': fathername.text,
            'dob': dob.text,
            'age': age.text,
            'gender': _selectgender,
            'phno': phno.text,
            'email': email.text,
            'nrcdivision': _selectednrccode,
            'nrccity': _selectednrccity,
            'nrcno': nrcno.text,
            'division': _selecteddivision,
            'city': _selectedcity,
            'quarter': _selectedquarter,
            'username': username.text,
            'password': password.text
          }));
      print(response.body);
      if (response.body == "success") {
        print("OK");
        EasyLoading.showSuccess('Save Success!');
        EasyLoading.dismiss();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getDivision();
    getNRCcode();
    //getRank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                Text('Name'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: name,
                  autofocus: false,
                  validator: validateNull,
                  decoration: buildInputDecoration(
                      'Enter Name', Icons.supervised_user_circle),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Father Name'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: fathername,
                  autofocus: false,
                  validator: validateNull,
                  decoration: buildInputDecoration(
                      'Enter Father Name', Icons.verified_user),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Date Of Birth"),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: dob,
                  autofocus: false,
                  validator: validateNull,
                  decoration: buildInputDecoration(
                      'Enter DOB', Icons.calendar_view_day),
                  onTap: () async {
                    var datedt = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    if (datedt == null) return;
                    dob.text = datedt.toString().substring(0, 10);

                    var days = DateTime.now().difference(datedt).inDays;

                    var age1 = days ~/ 360;

                    setState(() {
                      age.text = age1.toString();
                    });
                  },
                ),

                SizedBox(
                  height: 20.0,
                ),
                Text('Age'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: age,
                  readOnly: true,
                  autofocus: false,
                  validator: validateNull,
                  decoration:
                      buildInputDecoration('Enter Age', Icons.timelapse),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Gender"),
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
                    value: _selectgender,
                    hint: Text('Select Gender'),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Gender';
                      }
                      return null;
                    },
                    items: _genderlist.map(
                      (list) {
                        return DropdownMenuItem(
                          child: new Text(list),
                          value: list,
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectgender = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Phone No'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                    controller: phno,
                    autofocus: false,
                    validator: validateNull,
                    decoration:
                        buildInputDecoration('Enter Phone', Icons.phone)),
                SizedBox(
                  height: 20.0,
                ),
                Text('Email'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: email,
                  autofocus: false,
                  validator: validateEmail,
                  decoration:
                      buildInputDecoration('Enter Email', Icons.email_rounded),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('NRC'),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _selectednrccode,
                          onChanged: (newValue) {
                            setState(() {
                              _selectednrccode = newValue;
                              _selectednrccity = null;

                              getNRCCity();
                            });
                          },
                          items: nrccodelist.map(
                            (list) {
                              return DropdownMenuItem(
                                child: Text(list['d_code']),
                                value: list['d_id'].toString(),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _selectednrccity,
                          onChanged: (newValue) {
                            setState(() {
                              _selectednrccity = newValue;

                              // getNRCCity();
                            });
                          },
                          items: nrccitylist.map(
                            (list) {
                              return DropdownMenuItem(
                                child: Text(list['c_code']),
                                value: list['c_id'].toString(),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: value,
                          items: item
                              .map((item) => DropdownMenuItem(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            this.value = value;
                          }),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                Text('NRC No'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                    controller: nrcno,
                    autofocus: false,
                    validator: validateNull,
                    decoration: buildInputDecoration(
                        'Enter NRC no', Icons.card_membership)),
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
                  height: 20,
                ),
                Text('Username'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                    controller: username,
                    autofocus: false,
                    validator: validateNull,
                    decoration:
                        buildInputDecoration('Enter Username', Icons.android)),
                SizedBox(
                  height: 20.0,
                ),
                Text('Password'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: password,
                  autofocus: false,
                  obscureText: true,
                  validator: (value) =>
                      value.isEmpty ? "Please enter password" : null,
                  decoration:
                      buildInputDecoration('Enter Password', Icons.lock),
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
                      'Register',
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
