import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'ticket_view_design.dart';
import 'sidebar.dart';
import 'sidebar.dart' as s;
import 'main.dart' as m;

var ticket_data;

class View_ticket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('view tickets'),
          //backgroundColor: Colors.white,
        ),
        body: Ticket_view(),
        drawer: Sidebar(),
      ),
    );
  }
}

class Ticket_view extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ticketes();
  }
}

class ticketes extends State<Ticket_view> {
  @override
  Widget build(BuildContext context) {
    //ticket_data
    List<dynamic> data = s.ticket_data;
    // TODO: implement build
    return Scaffold(
        body: data.length!=0?ListView.separated(
            itemBuilder: (context, index) => Ticket_view_design(
                  ticket_id: int.parse(data[index]['ticket_id'].toString()),
                  departure: data[index]['icity_id'].toString(),
                  destination: data[index]['dcity_id'].toString(),
                  price: int.parse(data[index]['price'].toString()),
                  time: data[index]['time'].toString(),
                  plate_no: int.parse(data[index]['plate_no'].toString()),
                  seat_no: int.parse(data[index]['seat_no'].toString()),
                  date: data[index]['date'].toString(),
                ),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
            itemCount: data.length):Center(
            child:
            Text("no tickets"))
    );
  }
}
