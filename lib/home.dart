import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'search_result.dart';
import 'sidebar.dart';

var res;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
          drawer: Sidebar(),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text('Home'),
            //backgroundColor: Colors.white,
          ),
          body: Hom()),
    );
  }
}

class Hom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Homepage();
  }
}

class Homepage extends State<Hom> {
  TextEditingController departure = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController date = TextEditingController();
  Future search() async {
    if (departure.text == "" || destination.text == "" || date.text == "") {
      Fluttertoast.showToast(
          msg: "please fill all fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var response = await http.post(Uri.parse(
          //   "https:/http://undoctored-retailer.000webhostapp.com/bus/indx.php?page=search_ticket"),
          "http://10.0.2.2:8080/bb/indx.php?page=search_ticket"), body: {
        "dep": departure.text,
        "des": destination.text,
        "dat": date.text,
      });
      res = jsonDecode(response.body);

      if (res == "noticket") {
        Fluttertoast.showToast(
            msg: "there is no ticket available",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.lightBlueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        List<dynamic> data = res;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Search_result()),
        );
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
            Container(
              height: 300.0,
              width: 500.0,
              color: Colors.blueGrey,
              child: Image.asset('assets/ticket.PNG'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
              child: TextFormField(
                controller: departure,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'DEPARTURE',
                  icon: Icon(Icons.departure_board),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
              child: TextFormField(
                controller: destination,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'DESTINATION',
                  icon: Icon(Icons.departure_board),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
              child: TextFormField(
                controller: date,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'DATE',
                  icon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      date.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
              width: 200.0,
              child: TextButton(
                child: Text("SEARCH"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  search();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
