import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class Notifications extends StatelessWidget {
  final int? notificationID;
  final String? notificationBody;
  final String? date;

  Notifications({this.notificationID, this.notificationBody, this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Date: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  date!,
                  style: const TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            
            const SizedBox(
              height: 5,
            ),
            ExpandableText(
              notificationBody!,
              expandText: 'show more',
              collapseText: 'show less',
              maxLines: 1,
              linkColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
