import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';


abstract class ThemeText {
  static const TextStyle custom_style = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 40,
      height: 0.5,
      fontWeight: FontWeight.w600);
}
abstract class Decor {
  static const InputDecoration decorText = InputDecoration(
        enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        ),
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        // border: InputBorder.none,
        focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
           ),
        );

}
class CustomTextStyle {

  static TextStyle display5(BuildContext context) {
    return Theme.of(context).textTheme.body1
        .copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
        color: Colors.black);
  }
}

class CheckInternet {

    Future<bool> _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(
          'No internet',
          "You're not connected to a network"
      );
      return false;
    } else if (result == ConnectivityResult.mobile) {
      _showDialog(
          'Internet access',
          "You're connected over mobile data"
      );
      return true;
    } else if (result == ConnectivityResult.wifi) {
      _showDialog(
          'Internet access',
          "You're connected over wifi"
      );
      return true;
    }
    return false;
  }

  _showDialog(title, text) {
    showDialog(
      // context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}