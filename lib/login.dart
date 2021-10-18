import 'dart:convert';

import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/general/validate.dart';
import 'package:covid19_vaccination/general/widget.dart';
import 'package:covid19_vaccination/home.dart';
import 'package:covid19_vaccination/model/loginmodel.dart';
import 'package:covid19_vaccination/register/phoneotp.dart';
import 'package:covid19_vaccination/register/signup.dart';
import 'package:covid19_vaccination/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool _rememberMe = false;

  final username = TextEditingController();
  final password = TextEditingController();
  login _log;

  DateTime current;

  Future<bool> popped() {
    DateTime now = DateTime.now();
    if (current == null || now.difference(current) > Duration(seconds: 2)) {
      current = now;
      showToast("Press back again to exit !");
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  Future Login() async {
    final form = formKey.currentState;
    if (form.validate()) {
      EasyLoading.show(status: 'loading...');
      var url = Uri.parse(Config.path + "login.php");
      var response = await http.post(url,
          body: jsonEncode({
            'action': 'login',
            'username': username.text,
            'password': password.text
          }));

      if (response.statusCode == 200) {
        var responseString = response.body;
        return login.fromJson(json.decode(responseString));
        //print(_log.status);
      } else {
        //print('error');
        return null;
      }
    }
  }

  Future getsharePreference() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtusername = sharedPreferences.getString('username');
    setState(() {
      username.text = obtusername;
    });
    print(obtusername);
    // print(Config.psw);
  }

  @override
  void initState() {
    super.initState();
    getsharePreference();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return SystemNavigator.pop();
        },
        child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF73AEF5),
                          Color(0xFF61A4F1),
                          Color(0xFF478DE0),
                          Color(0xFF398AE5),
                        ],
                        stops: [0.1, 0.4, 0.7, 0.9],
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 120.0,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            _buildEmailTF(),
                            SizedBox(
                              height: 30.0,
                            ),
                            _buildPasswordTF(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildForgotPasswordBtn(),
                                _buildsignupBtn(),
                              ],
                            ),
                            _buildRememberMeCheckbox(),
                            _buildLoginBtn(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'UserName',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: username,
            keyboardType: TextInputType.name,
            validator: validateNull,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your username',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: password,
            validator: (value) =>
                value.isEmpty ? "Please enter password" : null,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => PhoneOTP()));
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildsignupBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUp()));
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Signup',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          final login log = await Login();
          setState(() {
            _log = log;
          });
          //_log == null ? Container() : print(_log.message);
          if (_log != null) {
            if (_log.status == true) {
              SharedPreferences share = await SharedPreferences.getInstance();
              share.setString("pid", _log.id);
              share.setString("psw", _log.psw);
              share.setString("name", _log.name);
              if (_rememberMe == true) {
                share.setString("username", username.text);
              } else {
                share.setString("username", '');
              }

              EasyLoading.showSuccess('Login Success!');
              EasyLoading.dismiss();

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }
            EasyLoading.dismiss();
            if (_log.message == "UserName Incorrect") {
              showAlertDialog(context, 'Wrong Username', 'Try Again');
            }
            if (_log.message == "Incorrect password") {
              showAlertDialog(context, 'Incorrect password', 'Try Again');
            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
