// import 'package:covid19_vaccination/general/config.dart';
// import 'package:covid19_vaccination/general/widget.dart';
// import 'package:covid19_vaccination/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import "package:flutter/material.dart";
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// enum MobileVerificationState {
//   SHOW_MOBILE_FORM_STATE,
//   SHOW_OTP_FORM_STATE,
// }

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   MobileVerificationState currentState =
//       MobileVerificationState.SHOW_MOBILE_FORM_STATE;
//   GlobalKey<FormState> formKey = GlobalKey();

//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();

//   Future checkphone() async {
//     EasyLoading.show(status: 'loading...');
//     final form = formKey.currentState;
//     if (form.validate()) {
//       var url = Uri.parse(Config.path + "login.php");
//       var response = await http.post(url,
//           body: jsonEncode(
//               {'action': 'checkphone', 'phno': phoneController.text}));

//       if (response.body == 'success') {
//         return 1;
//       } else {
//         //print('error');
//         return 0;
//       }
//     }
//   }

//   FirebaseAuth _auth = FirebaseAuth.instance;

//   String verificationId;

//   bool showLoading = false;

//   void signInWithPhoneAuthCredential(
//       PhoneAuthCredential phoneAuthCredential) async {
//     setState(() {
//       showLoading = true;
//     });

//     try {
//       final authCredential =
//           await _auth.signInWithCredential(phoneAuthCredential);

//       setState(() {
//         showLoading = false;
//       });

//       if (authCredential?.user != null) {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => Login()));
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         showLoading = false;
//       });

//       _scaffoldKey.currentState
//           .showSnackBar(SnackBar(content: Text(e.message)));
//     }
//   }

//   getMobileFormWidget(context) {
//     return Form(
//       key: formKey,
//       child: Column(
//         children: [
//           Spacer(),
//           TextField(
//             controller: phoneController,
//             decoration: InputDecoration(
//               hintText: "Phone Number",
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           FlatButton(
//             onPressed: () async {
//               int a = await checkphone();
//               EasyLoading.dismiss();
//               if (a == 1) {
//                 setState(() {
//                   showLoading = true;
//                 });

//                 await _auth.verifyPhoneNumber(
//                   phoneNumber: phoneController.text,
//                   verificationCompleted: (phoneAuthCredential) async {
//                     setState(() {
//                       showLoading = false;
//                     });
//                     //signInWithPhoneAuthCredential(phoneAuthCredential);
//                   },
//                   verificationFailed: (verificationFailed) async {
//                     setState(() {
//                       showLoading = false;
//                     });
//                     _scaffoldKey.currentState.showSnackBar(
//                         SnackBar(content: Text(verificationFailed.message)));
//                   },
//                   codeSent: (verificationId, resendingToken) async {
//                     setState(() {
//                       showLoading = false;
//                       currentState =
//                           MobileVerificationState.SHOW_OTP_FORM_STATE;
//                       this.verificationId = verificationId;
//                     });
//                   },
//                   codeAutoRetrievalTimeout: (verificationId) async {},
//                 );
//               } else {
//                 showAlertDialog(context, 'Wrong Phone Number', 'Try Again');
//               }
//             },
//             child: Text("SEND"),
//             color: Colors.blue,
//             textColor: Colors.white,
//           ),
//           Spacer(),
//         ],
//       ),
//     );
//   }

//   getOtpFormWidget(context) {
//     return Column(
//       children: [
//         Spacer(),
//         TextField(
//           controller: otpController,
//           decoration: InputDecoration(
//             hintText: "Enter OTP",
//           ),
//         ),
//         SizedBox(
//           height: 16,
//         ),
//         FlatButton(
//           onPressed: () async {
//             PhoneAuthCredential phoneAuthCredential =
//                 PhoneAuthProvider.credential(
//                     verificationId: verificationId,
//                     smsCode: otpController.text);

//             signInWithPhoneAuthCredential(phoneAuthCredential);
//           },
//           child: Text("VERIFY"),
//           color: Colors.blue,
//           textColor: Colors.white,
//         ),
//         Spacer(),
//       ],
//     );
//   }

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         body: Container(
//           child: showLoading
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
//                   ? getMobileFormWidget(context)
//                   : getOtpFormWidget(context),
//           padding: const EdgeInsets.all(16),
//         ));
//   }
// }
