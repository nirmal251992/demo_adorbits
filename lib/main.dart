import 'package:demo_adorebits/list_users.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}
class _MyLoginPageState extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


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
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Login Success ",toastLength: Toast.LENGTH_LONG);
      Navigator.push(context, MaterialPageRoute(builder: (context) => list_users()));
    }
  else
    {
      Fluttertoast.showToast(msg: "Login Failed ",toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/login_bg.png"), fit: BoxFit.fill,
        ),
      ),
      child:  Scaffold(
          backgroundColor: Colors.transparent,
        //resizeToAvoidBottomPadding: false,
        //resizeToAvoidBottomPadding: false,
        // appBar: AppBar(
        //   title: Text(''),
        // ),

        body:
          ListView(
            children: <Widget>[
              Container(

                margin: const EdgeInsets.only(top: 10.0),
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
                padding: EdgeInsets.fromLTRB(40, 50, 5, 5),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 35),
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
                //color: Colors.redAccent,
                height: MediaQuery.of(context).size.height*0.6,
                // alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20, 120, 20, 20),
                child:Column(
                  children: <Widget>[
                    TextField(
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
                    SizedBox(height: 20),
                    TextField(
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
                    SizedBox(height: 40),
                    Row(
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
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => list_users()));
                              _loginState(nameController.text, passwordController.text);
                              //
                              // print(nameController.text);
                              //print(passwordController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => register()));
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
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  )
              )
            ],
          )
      ),
    );
  }
}


