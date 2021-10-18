import 'package:covid19_vaccination/login.dart';
import 'package:covid19_vaccination/profile/profile.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('my', 'MY')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID19 Vaccination',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
      builder: EasyLoading.init(),
    );
  }
}

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new LoginScreen(),
      //navigateAfterSeconds: new Profile(),
      backgroundColor: Colors.black,
      title: new Text('COVID19 Vaccination',
          textScaleFactor: 2, style: TextStyle(color: Colors.white)),
      image: new Image.asset('assets/icon/covid19.png'),
      loadingText: Text(
        "Loading",
        style: TextStyle(color: Colors.white),
      ),
      photoSize: 150.0,
      loaderColor: Colors.red,
    );
  }
}
