import 'package:flutter/material.dart';

class Ticket_view_design extends StatelessWidget {
  final int? ticket_id;
  final String? departure;
  final String? destination;
  final String? date;
  final int? price;
  final String? time;
  final int? plate_no;
  final int? seat_no;

  Ticket_view_design(
      {this.ticket_id,
      this.departure,
      this.destination,
      this.price,
      this.time,
      this.plate_no,
      this.seat_no,
      this.date});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Ticket Id:-  ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                Text(
                  ticket_id.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ],
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
                Text(
                  'the bus plate number is:-  ',
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87),
                ),
                Text(
                  plate_no.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'your seat number is:',
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  seat_no.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
