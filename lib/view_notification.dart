import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'notification_design.dart';
import 'sidebar.dart' as s;

class view_notification extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
          //backgroundColor: Colors.white,
        ),
          body: Notify(),
          drawer: Sidebar(),
      ),
    );
  }
}
class Notify extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Notificationes();
  }
}
class Notificationes extends State<Notify>{
  @override
  Widget build(BuildContext context) {
    //notification_data
    List<dynamic> data = s.notification_data;

    // TODO: implement build
    return Scaffold(
        body: data.length!=0?ListView.separated(
          itemBuilder: (context, index) =>Notifications(
            notificationID: int.parse(data[index]['notification_id'].toString()),
            notificationBody: data[index]['notification_body'].toString(),
            date : data[index]['date'].toString(),

          ),
          itemCount: data.length,
          separatorBuilder: (context,index) => Divider(
            color: Colors.black,
          ),
        ):Center(
            child:
            Text("no notification"))
    );
  }

}