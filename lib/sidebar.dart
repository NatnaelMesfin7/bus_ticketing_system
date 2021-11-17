import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';
import 'view_notification.dart';
import 'balance.dart';
import 'view_ticket.dart';
import 'home.dart';
import 'change_pass.dart';
import 'package:http/http.dart' as http;
import 'main.dart' as ma;

var notification_data;
var ticket_data;

class Sidebar extends StatelessWidget {
  Future notify() async {
    var response = await http.post(
        Uri.parse("http://10.0.2.2:8080/bb/indx.php?page=get_notification"),
        body: {
          "user_id": ma.accid,
        });
    notification_data = json.decode(response.body);
  }

  Future view_tickets() async {
    var response = await http.post(
        Uri.parse("http://10.0.2.2:8080/bb/indx.php?page=view_ticket"),
        body: {
          "user_id": ma.accid,
        });
    ticket_data = json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('View Ticket'),
            onTap: () => {
              view_tickets(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => View_ticket()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('balance'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Balance()),
              )
            },
          ),
          ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              onTap: () => {
                    notify(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => view_notification()),
                    )
                  }),
          ListTile(
              leading: Icon(Icons.lock_open),
              title: Text('change password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => changepass()),
                );
              }),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                notification_data = [];
                ticket_data = [];
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }),
        ],
      ),
    );
  }
}
