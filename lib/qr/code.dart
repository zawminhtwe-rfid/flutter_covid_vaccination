import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'package:covid19_vaccination/general/config.dart';
import 'package:covid19_vaccination/general/validate.dart';
import 'package:covid19_vaccination/general/widget.dart';
import 'package:covid19_vaccination/model/codemodel.dart';
import 'package:covid19_vaccination/qr/qr.dart';

class Code extends StatefulWidget {
  String aid;
  Code({this.aid});
  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  GlobalKey<FormState> formKey = GlobalKey();
  final code = TextEditingController();
  // CodeModel _code;

  Future checkcode() async {
    EasyLoading.show(status: 'loading...');
    final form = formKey.currentState;
    if (form.validate()) {
      var url = Uri.parse(Config.path + "peopleregister.php");
      var response = await http.post(url,
          body: jsonEncode(
              {'action': 'checkcode', 'code': code.text, 'aid': widget.aid}));

      if (response.body == "success") {
        EasyLoading.showSuccess('Success!');
        EasyLoading.dismiss();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QrPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Code'),
        centerTitle: true,
        backgroundColor: Colors.black,
        //automaticallyImplyLeading: false,
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
                Text('Code'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: code,
                  autofocus: false,
                  validator: validateNull,
                  decoration: buildInputDecoration('Enter Code', Icons.code),
                ),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (code.text != Config.pid) {
                      showAlertDialog(context, 'Wrong Code', 'Try Again');
                    }
                    if (code.text == Config.pid) {
                      checkcode();
                      // EasyLoading.showSuccess('Success!');
                      // EasyLoading.dismiss();

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => QrPage()));
                    }
                    code.clear();
                    // if (code.text == Config.pid) {
                    //   final CodeModel chkcode = await checkcode();

                    //   setState(() {
                    //     _code = chkcode;
                    //   });
                    //   //_log == null ? Container() : print(_log.message);
                    //   if (_code != null) {
                    //     if (_code.status == true) {
                    //       EasyLoading.showSuccess('Success!');
                    //       EasyLoading.dismiss();

                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => QrPage()));
                    //     }
                    //     EasyLoading.dismiss();
                    //     if (_code.message == "Wrong Code") {
                    //       showAlertDialog(context, 'Wrong Code', 'Try Again');
                    //     }
                    //   }
                    // } else {
                    //   showAlertDialog(context, 'Wrong Code', 'Try Again');
                    // }
                  },
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Enter',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 45,
                  minWidth: 600,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ],
            ),
          ),
        ),
      ),
      // longButtons('login'.tr(), Login),
    );
  }
}
