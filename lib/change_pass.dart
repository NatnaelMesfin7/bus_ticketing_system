import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart' as m;
import 'sidebar.dart';
import 'main.dart';

class Change_pass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          //backgroundColor: Colors.white,
        ),
        drawer: Sidebar(),
        body: changepass(),
      ),
    );
  }
}

class changepass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return changep();
  }
}

class changep extends State<changepass> {
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass1 = TextEditingController();
  TextEditingController newpass2 = TextEditingController();

  Future changepassword() async {
    if (newpass2.text == "" || newpass1.text == "" || oldpass.text == "") {
      Fluttertoast.showToast(
          msg: "please fill all fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if (newpass1.text != newpass2.text) {
        Fluttertoast.showToast(
            msg: "the new passwords doesn't match",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        var respons = await http.post(
            Uri.parse("http://10.0.2.2:8080/bb/indx.php?page=changepass"),
            body: {
              "user_id": m.useid,
              "oldpass": oldpass.text.toString(),
              "newpass": newpass1.text.toString(),
            });
        var res = json.decode(respons.body);
        if (res == "error") {
          Fluttertoast.showToast(
              msg: "incorrect password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        } else if (res == "success") {
          Fluttertoast.showToast(
              msg: "password changed successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }
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
            color: Colors.blue,
            height: 300.0,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(1.0, 100.0, 3.0, 4.0),
                  child: Center(
                      child: Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: TextFormField(
              validator: (value) {
                if (value == null) return "enter password";
                return null;
              },
              controller: oldpass,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'OLD PASSWORD',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: TextFormField(
              validator: (value) {
                if (value == null) return "new password";
                return null;
              },
              controller: newpass1,
              obscureText: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'NEW PASSWORD',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: TextFormField(
              validator: (value) {
                if (value == null) return "enter new password";
                return null;
              },
              controller: newpass2,
              obscureText: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: ' RE-ENTER NEW PASSWORD',
              ),
            ),
          ),
          Container(
            height: 60.0,
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
            child: TextButton(
              onPressed: () {
                changepassword();
              },
              child: Text("Change Password"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlueAccent),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
          ),
        ])));
  }
}
