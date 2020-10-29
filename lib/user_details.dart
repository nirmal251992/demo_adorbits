import 'package:demo_adorebits/constant.dart';
import 'package:demo_adorebits/list_users.dart';
import 'package:flutter/material.dart';

class Userdetails extends StatefulWidget {
  Data data1;
  Userdetails({Key key, @required this.data1}) : super(key: key);
  @override
  UserdetailsState createState() => UserdetailsState();
}

class UserdetailsState extends State<Userdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User_Details'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.data1.avatar),
              ),
              SizedBox(height: 20),
              Text(widget.data1.email,style: TextStyle(fontSize: 20),),
              SizedBox(height: 20),
              Text(widget.data1.firstName),
            ],
          ),
        ),
    );
  }
}
