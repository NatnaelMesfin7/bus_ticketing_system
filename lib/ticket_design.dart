import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'main.dart' as acc;
import 'balance.dart';

class Ticket extends StatelessWidget {
  final int? ticketid;
  final String? boname;
  final String? departure;
  final String? destination;
  final String? date;
  final String? time;
  final int? price;
  final int? seat_no;

  Ticket(
      {this.ticketid,
      this.boname,
      this.departure,
      this.destination,
      this.date,
      this.price,
      this.time,
      this.seat_no});

  Future buyticket() async {
    var response = await http.post(
        Uri.parse("http://10.0.2.2:8080/bb/indx.php?page=purchase_ticket"),
        body: {
          "user_id": acc.accid,
          "ticket_id": ticketid.toString(),
          "price": price.toString(),
          "seat_no": seat_no.toString(),
        });
    var data = json.decode(response.body);
    if (data == "success") {
      Fluttertoast.showToast(
          msg: "success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors. blueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              boname!,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'Date:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(date!,
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic)),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Time:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(time!,
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  departure!,
                  style: const TextStyle(
                      fontSize: 17, fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('==>'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  destination!,
                  style: const TextStyle(
                      fontSize: 17, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'Price:',
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  price.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.indigo.shade900),
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text(
                    'Buy',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    buyticket();
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
