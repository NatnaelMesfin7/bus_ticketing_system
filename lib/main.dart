import 'dart:convert';
import 'package:bus_ticketing_app/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'signup.dart';

var accid;
var accbal;
var useid;

class Account {
  // ignore: non_constant_identifier_names
  final String user_id;
  // ignore: non_constant_identifier_names
  final String account_id;
  final String balance;
  // ignore: non_constant_identifier_names
  Account(
      {required this.user_id, required this.account_id, required this.balance});
  factory Account.fromJson(Map<String, dynamic> usersjson) => Account(
      user_id: usersjson["user_id"],
      account_id: usersjson["account_id"],
      balance: usersjson["balance"]);
}

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      theme: ThemeData(primaryColor: Colors.blue),
      home: LoginHomePage(title: "Loginhomepage"),
    );
  }
}
 
class LoginHomePage extends StatefulWidget {
  LoginHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    return _Log();
  }
}

class _Log extends State<LoginHomePage> {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  Future login() async {
    if (uname.text == "" || pass.text == "") {
      Fluttertoast.showToast(
          msg: "username or password empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var response = await http
          .post(Uri.parse("http://10.0.2.2:8080/bb/indx.php?page=tlog"), body: {
        "user": uname.text,
        "pass": pass.text,
      });
      var user_data = json.decode(response.body);
      if (user_data == -1) {
        Fluttertoast.showToast(
            msg: "Incorrect username or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        var a = Account.fromJson(user_data);
        accid = a.account_id;
        useid = a.user_id;
        accbal = a.balance;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black12,
              height: 340.0,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(1.0, 0.0, 3.0, 4.0),
                    child: Image.asset('assets/Ebus.jpg'),
                  ),
                  Center(
                      child: Text(
                    "Sign in",
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 40),
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null) return "enter username";
                  return null;
                },
                controller: uname,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'USERNAME',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: TextFormField(
                validator: (value) {
                  if (value == null) return "enter password";
                  return null;
                },
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'password',
                ),
              ),
            ),
            Container(
              height: 60.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
              child: TextButton(
                onPressed: () {
                  login();
                },
                child: Text("Login"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
              child: Text(
                "OR",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 60.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                child: Text("SIGNUP"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
