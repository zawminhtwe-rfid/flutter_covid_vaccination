import 'package:covid19_vaccination/general/widget.dart';
import 'package:covid19_vaccination/home.dart';
import 'package:covid19_vaccination/register/sendotp.dart';
import 'package:flutter/material.dart';

class PhoneOTP extends StatefulWidget {
  @override
  _PhoneOTPState createState() => _PhoneOTPState();
}

class _PhoneOTPState extends State<PhoneOTP> {
  final email = TextEditingController();
  final userotp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone OTP Send'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Home(),
      ),
    );
  }
}
