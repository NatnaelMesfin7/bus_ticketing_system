//import 'dart:html';
import 'sidebar.dart';
import 'package:flutter/material.dart';
import 'ticket_design.dart';
import 'home.dart' as hm;

void display(List<dynamic> data) {
  if (data.length <= 0) {
    Text("no ticket available");
  } else {}
}

class Search_result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search Result'),
          //backgroundColor: Colors.white,
        ),
        drawer: Sidebar(),
        body: Searchr(),
      ),
    );
  }
}

class Searchr extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Searchpage();
  }
}

class Searchpage extends State<Searchr> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> data = hm.res;
    //TODO: implement build
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) => Ticket(
          ticketid: int.parse(data[index]['ticket_id'].toString()),
          boname: data[index]['bus_organization_id'].toString(),
          departure: data[index]['icity_id'].toString(),
          destination: data[index]['dcity_id'].toString(),
          date: data[index]['date'].toString(),
          price: int.parse(data[index]['price'].toString()),
          time: data[index]['time'].toString(),
          seat_no: int.parse(data[index]['available_seats'].toString()),
        ),
        itemCount: data.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.green,
        ),
      ),
    );
  }
}
