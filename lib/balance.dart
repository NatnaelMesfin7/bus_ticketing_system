import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'sidebar.dart';
import 'main.dart' as a;

class Balance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Balance'),
          //backgroundColor: Colors.white,
        ),
        drawer: Sidebar(),
        body: Balances(),
      ),
    );
  }
}

class Balances extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Balancepage();
  }
}

class Balancepage extends State<Balances> {
  //bool isNumericUsingRegularExpression(String string) {
  //final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  //return numericRegex.hasMatch(string);
  //}

  TextEditingController voucher_no = TextEditingController();
  Future add_voucher() async {
    if (voucher_no.text == "" || double.tryParse(voucher_no.text) == null) {
      Fluttertoast.showToast(
          msg: "please insert vouche no",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var response = await http.post(
          Uri.parse("http://10.0.2.2:8080/bb/indx.php?page=fill_voucher"),
          body: {
            "voucher_no": voucher_no.text,
            "user_id": a.useid.toString(),
            "balance": a.accbal.toString(),
          });
      if (response.statusCode == 200) {
        var dat = json.decode(response.body);
        if (dat == "error") {
          Fluttertoast.showToast(
              msg: "error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueAccent,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          a.accbal = dat.toString();
          Fluttertoast.showToast(
              msg: "added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueAccent,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "connection problem",
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
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(1.0, 66.0, 3.0, 4.0),
              height: 200.0,
              width: 500.0,
              color: Colors.black38,
              child: Column(
                children: [
                  Text(
                    "Your current balance is",
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(1.0, 10.0, 3.0, 4.0),
                    width: 80.0,
                    height: 50.0,
                    color: Colors.transparent,
                    child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                              bottomLeft: const Radius.circular(40.0),
                              bottomRight: const Radius.circular(40.0),
                            )),
                        child: new Center(
                          child: new Text(
                            a.accbal,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  Text(
                    "Birr",
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(1.0, 25.0, 3.0, 4.0),
              child: Text("REFILL BALANCE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0,
                      color: Colors.black54))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: TextFormField(
                controller: voucher_no,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'VOUCHER NO',
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            width: 100.0,
            height: 50.0,
            child: TextButton(
              child: Text("Refill"),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                add_voucher();
              },
            ),
          ),
        ],
      ),
    ));
  }
}
