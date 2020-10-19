import 'package:flutter/material.dart';

enum Gender { Male, Female }

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);
  @override
  MyStatefulWidgetState createState() => MyStatefulWidgetState();
}
/// This is the private State class that goes with MyStatefulWidget.
class MyStatefulWidgetState extends State<MyStatefulWidget> {
  Gender character = Gender.Male;
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ListTile(
          title: const Text('Male'),
          leading: Radio(
            value: Gender.Male,
            groupValue: character,
            onChanged: (Gender value) {
              setState(() {
                character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Female'),
          leading: Radio(
            value: Gender.Female,
            groupValue: character,
            onChanged: (Gender value) {
              setState(() {
                character = value;
              });
            },
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}