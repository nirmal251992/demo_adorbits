
import 'package:demo_adorebits/list_users.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'constant.dart';
import 'list_users.dart';

class MyApp extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}
class _MyLoginPageState extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ProgressDialog pr;

  void _loginState(String email, String password) async {
    final http.Response response = await http.post(
        'https://reqres.in/api/login',
        // headers: <String, String>{
        //   'Accept': 'application/json',
        // },
        body: {
          'email': email,
          'password': password,
        });
    print(response.body);
    var convertDataToJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      Fluttertoast.showToast(msg: "Login Success ",toastLength: Toast.LENGTH_LONG);
      Navigator.push(context, MaterialPageRoute(builder: (context) => list_users()));

    }
    else
    {
      Fluttertoast.showToast(msg: convertDataToJson['error'],toastLength: Toast.LENGTH_LONG);
      pr.hide().then((isHidden) {
        print(isHidden);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    return  Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/login_bg.png"), fit: BoxFit.fill,
        ),
      ),
      child:  Scaffold(
        //resizeToAvoidBottomPadding:  false,
        backgroundColor: Colors.transparent,
        //resizeToAvoidBottomPadding: false,
        //resizeToAvoidBottomPadding: false,
        // appBar: AppBar(
        //   title: Text(''),
        // ),
        body: Container(
          child: SingleChildScrollView (
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  height: 50,
                  //color: Colors.amber,
                  alignment: Alignment.topLeft,
                  // padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                  child: IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      //Navigator.pop(context);
                    },
                    focusColor: Colors.white,
                    //padding: EdgeInsets.all(10.0),
                    icon: Icon(Icons.keyboard_arrow_left,color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(40, 20, 5, 5),
                  child: Text(
                    'Welcome',
                    style: CustomTextStyle.display5(context).copyWith(color: Colors.black),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(40, 10, 5, 5),
                  child: Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 35),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.6,
                  padding: EdgeInsets.only(top: 100),
                  child: ListView(
                    children: [

                      Container(
                        height:50,

                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            labelText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            labelText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 70,
                        // color: Colors.green,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Sign in',
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 30.0,color: Color.fromRGBO(81, 87, 96, 1)
                              ),
                            ),
                            ButtonTheme(
                              minWidth: 70,
                              height: 70,
                              child:RaisedButton(
                                shape: CircleBorder(),
                                textColor: Colors.white,
                                color: Colors.black54,
                                child: Image.asset("assets/right-arrow.png",width: 20,height: 20,),
                                onPressed: () {
                                  pr.show();
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => list_users()));
                                  _loginState(nameController.text, passwordController.text);
                                  // print(nameController.text);
                                  //print(passwordController.text);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  height: 50,
                  //color: Colors.amber,
                  //margin: EdgeInsets.only(bottom: 0.0),
                  // alignment: Alignment.bottomCenter ,
                  padding: EdgeInsets.only(bottom: 10.0,left: 10.0,right: 20.0),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        textColor: Colors.black,
                        child: Text(
                          'Sign up',
                          style: TextStyle(fontSize: 18,
                              fontWeight:FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(81, 87, 96, 1)
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                          //signup screen
                        },
                      ),
                      FlatButton(
                        textColor: Colors.black,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight:FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(81, 87, 96, 1)
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => list_users()));
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


