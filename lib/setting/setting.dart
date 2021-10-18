import 'package:covid19_vaccination/setting/changepsw.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: Text('langtitle'.tr()),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.flag_rounded),
                title: Text('languageen'.tr()),
                onTap: () {
                  context.locale = Locale("en", "US");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('change english language successful.'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.purple[300],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.flag_rounded),
                title: Text('languagemy'.tr()),
                onTap: () {
                  context.locale = Locale("my", "MY");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('change myanmar language successful.'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.purple[300],
                    ),
                  );
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                },
                leading: Icon(Icons.lock_clock),
                title: Text('Change Password'),
                trailing: Icon(Icons.arrow_right_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
