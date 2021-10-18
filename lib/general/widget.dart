import 'package:covid19_vaccination/general/validate.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//textformfield decoration
InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

//button box
MaterialButton longButtons(String title, Function fun,
    {Color color: Colors.blue, Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

//textFormField
Widget textFormField() {
  String _username;
  return TextFormField(
    autofocus: false,
    validator: validateEmail,
    onSaved: (value) => _username = value,
    decoration: buildInputDecoration("Enter Email", Icons.email),
  );
}

//passwordFormField
Widget passFormField() {
  String _password;
  return TextFormField(
    autofocus: false,
    obscureText: true,
    validator: (value) => value.isEmpty ? 'Please enter password' : null,
    onSaved: (value) => _password = value,
    decoration: buildInputDecoration("Enter Password", Icons.lock),
  );
}

//FlatButton
Widget flatButton() {
  return Container(
    margin: EdgeInsets.all(25),
    child: FlatButton(
      child: Text(
        'LogIn',
        style: TextStyle(fontSize: 20.0),
      ),
      color: Colors.blueAccent,
      textColor: Colors.white,
      onPressed: () {},
    ),
  );
}

Widget raisedButton() {
  return RaisedButton(
    child: Text(
      "Click Here",
      style: TextStyle(fontSize: 20),
    ),
    onPressed: () {},
    color: Colors.red,
    textColor: Colors.yellow,
    padding: EdgeInsets.all(8.0),
    splashColor: Colors.grey,
  );
}

Widget floatingAction() {
  return FloatingActionButton(
    child: Icon(Icons.navigation),
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    onPressed: () => {},
  );
}

Widget iconButton() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      IconButton(
        icon: Icon(Icons.volume_up),
        iconSize: 50,
        color: Colors.brown,
        tooltip: 'Increase volume by 5',
        onPressed: () {},
      ),
      Text('Speaker Volume'),
    ],
  );
}

Widget outlineButton() {
  return OutlineButton(
    child: Text(
      "Outline Button",
      style: TextStyle(fontSize: 20.0),
    ),
    highlightedBorderColor: Colors.red,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    onPressed: () {},
  );
}

Widget buttomBar() {
  return ButtonBar(
    alignment: MainAxisAlignment.end,
    children: <Widget>[
      RaisedButton(
        child: new Text('Javatpoint'),
        color: Colors.lightGreen,
        onPressed: () {/** */},
      ),
      FlatButton(
        child: Text('Flutter'),
        color: Colors.lightGreen,
        onPressed: () {/** */},
      ),
      FlatButton(
        child: Text('MySQL'),
        color: Colors.lightGreen,
        onPressed: () {/** */},
      ),
    ],
  );
}

Widget row() {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(12.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.green),
          child: Text(
            "React.js",
            style: TextStyle(color: Colors.yellowAccent, fontSize: 25),
          ),
        ),
        Container(
          margin: EdgeInsets.all(15.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.green),
          child: Text(
            "Flutter",
            style: TextStyle(color: Colors.yellowAccent, fontSize: 25),
          ),
        ),
        Container(
          margin: EdgeInsets.all(12.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.green),
          child: Text(
            "MySQL",
            style: TextStyle(color: Colors.yellowAccent, fontSize: 25),
          ),
        ),
        Container(
          margin: EdgeInsets.all(12.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.green),
          child: Text(
            "MySQL",
            style: TextStyle(color: Colors.yellowAccent, fontSize: 25),
          ),
        ),
      ]);
}

Widget form(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  return Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            icon: const Icon(Icons.person),
            hintText: 'Enter your full name',
            labelText: 'Name',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: const Icon(Icons.phone),
            hintText: 'Enter a phone number',
            labelText: 'Phone',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter valid phone number';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: const Icon(Icons.calendar_today),
            hintText: 'Enter your date of birth',
            labelText: 'Dob',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter valid date';
            }
            return null;
          },
        ),
        new Container(
            padding: const EdgeInsets.only(left: 150.0, top: 40.0),
            child: new RaisedButton(
              child: const Text('Submit'),
              onPressed: () {
                // It returns true if the form is valid, otherwise returns false
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Data is in processing.')));
                }
              },
            )),
      ],
    ),
  );
}

showAlertDialog(BuildContext context, String title, String msg) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(msg),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

textFieldDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField AlertDemo'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "TextField in Dialog"),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

Widget card() {
  return Container(
    height: 200,
    padding: new EdgeInsets.all(10.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.red,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album, size: 60),
            title: Text('Sonu Nigam', style: TextStyle(fontSize: 30.0)),
            subtitle: Text('Best of Sonu Nigam Music.',
                style: TextStyle(fontSize: 18.0)),
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                child: const Text('Play'),
                onPressed: () {/* ... */},
              ),
              RaisedButton(
                child: const Text('Pause'),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
}

Widget checkBox() {
  bool value = false;
  return Row(children: <Widget>[
    SizedBox(
      width: 10,
    ),
    Text(
      'Checkbox without Header and Subtitle: ',
      style: TextStyle(fontSize: 17.0),
    ),
    Checkbox(
      checkColor: Colors.greenAccent,
      activeColor: Colors.red,
      value: value,
      onChanged: (bool value) {
        // setState(() {
        //   this.valuefirst = value;
        // });
      },
    ),
  ]);
}

Widget layout(String name, String description, String image, String price) {
  return Container(
      padding: EdgeInsets.all(2),
      height: 110,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.green,
          elevation: 10,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(image),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(description),
                            Text("Price: " + price.toString()),
                          ],
                        )))
              ])));
}

Widget dropDownButton() {
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation;
  return Container(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: DropdownButton(
          hint: Text(''), // Not necessary for Option 1
          value: _selectedLocation,
          onChanged: (newValue) {
            // setState(() {
            //   _selectedLocation = newValue;
            //   print(_selectedLocation);
            // });
          },
          items: _locations.map((location) {
            return DropdownMenuItem(
              child: new Text(location),
              value: location,
            );
          }).toList(),
        ),
      ),
    ),
  );
}

Widget showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.purple[300],
    ),
  );
}
