import 'dart:convert';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Signup",
      theme: ThemeData.light(),
      home: Supp(),
    );
  }
}

class Supp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Sup();
  }
}

class Sup extends State<Supp> {
  TextEditingController firstname = TextEditingController();
  TextEditingController fathername = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController uname = TextEditingController();
  TextEditingController pword = TextEditingController();
  TextEditingController repword = TextEditingController();
  Future signsup() async {
    if (firstname.text == "" ||
        fathername.text == "" ||
        lastname.text == "" ||
        phoneno.text == "" ||
        uname.text == "" ||
        pword.text == "") {
      Fluttertoast.showToast(
          msg: "Please fill all the fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var response = await http.post(
          Uri.parse("http://10.0.2.2:8080/bb/indx.php?page=add_traveller"),
          body: {
            "name": firstname.text,
            "fathername": fathername.text,
            "lastname": lastname.text,
            "phoneno": phoneno.text,
            "uname": uname.text,
            "password": pword.text,
          });
      var data = json.decode(response.body);
      if (data == "accountadded") {
        Fluttertoast.showToast(
            msg: "Account Created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        Fluttertoast.showToast(
            msg: "username exists",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'SIGNUP',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Container(
              width: 200.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: TextFormField(
                controller: firstname,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: TextFormField(
                controller: fathername,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Father Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: TextFormField(
                controller: lastname,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: TextFormField(
                controller: phoneno,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: TextFormField(
                controller: uname,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'UserName',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              child: TextFormField(
                controller: pword,
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'PASSWORD',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
              width: 30.0,
              height: 40.0,
              child: TextButton(
                child: Text("SIGNUP"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  signsup();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
