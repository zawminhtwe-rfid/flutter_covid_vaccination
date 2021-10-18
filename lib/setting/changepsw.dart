import 'dart:convert';
import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/general/widget.dart';
import 'package:covid19_vaccination/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class ChangePwdmodel {
  bool status;
  String message;

  ChangePwdmodel({this.status, this.message});

  ChangePwdmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  final curpass = TextEditingController();
  final password = TextEditingController();
  final compassword = TextEditingController();
  ChangePwdmodel _change;

  @override
  Future editpwdFun() async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse(Config.path + 'changepwd.php');
    var response = await http.post(url,
        body: jsonEncode({
          'action': 'changepwd',
          'curpassword': curpass.text,
          'newpassword': password.text,
          'aid': Config.pid
        }));
    if (response.statusCode == 200) {
      var responseString = response.body;
      return ChangePwdmodel.fromJson(json.decode(responseString));
      //print(_log.status);
    } else {
      //print('error');
      return null;
    }
  }

  Widget build(BuildContext context) {
    void doChangePassword() {}
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
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
                Text("curpassword".tr()),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: curpass,
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
                Text("newpassword".tr()),
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
                Text("confirmpassword".tr()),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: compassword,
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
                  onPressed: () async {
                    if (Config.psw != curpass.text) {
                      showAlertDialog(
                          context, 'Error', 'Your current Password is wrong');
                    } else {
                      if (password.text != compassword.text) {
                        showAlertDialog(context, 'Error',
                            'Your New Password and Confirm Password must be same');
                      } else {
                        final ChangePwdmodel change = await editpwdFun();
                        setState(() {
                          _change = change;
                        });
                        if (_change != null) {
                          if (_change.status == true) {
                            EasyLoading.showSuccess(
                                'Password has been Changed');
                            EasyLoading.dismiss();
                            SharedPreferences share =
                                await SharedPreferences.getInstance();
                            share.setString("psw", compassword.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }
                        }
                      }
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Change Password',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 45,
                  minWidth: 600,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
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
