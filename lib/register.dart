import 'package:demo_adorebits/constant.dart';
import 'package:demo_adorebits/list_users.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:progress_dialog/progress_dialog.dart';

enum Gender { Male, Female }
enum Language {English , Hindi, Gujarati}

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);
  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<Register> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateofBirthController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  Gender character = Gender.Male;
  String name, email, mobile;
  bool _validate = false;
  bool eng = false;
  bool hindi = false;
  bool guj = false;
  Country _selected;
  // @override
  // void dispose() {
  //   emailController.dispose();
  //   super.dispose();
  // }
  DateTime selectedDate = DateTime.now();

  void _registerState(String email, String password) async {
    final http.Response response = await http.post(
        'https://reqres.in/api/register',
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
      Fluttertoast.showToast(msg: "User is Register Successfully ",
          toastLength: Toast.LENGTH_LONG);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => list_users()));
    }
    else {

        pr.hide().then((isHidden) {
          print(isHidden);
        });
        Fluttertoast.showToast(
            msg: convertDataToJson['error'], toastLength: Toast.LENGTH_LONG);

    }
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now()
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String date = new DateFormat('dd-MM-yyyy').format(selectedDate);
        dateofBirthController.text = date;
            //selectedDate.toString();
      });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/signup_bg.png"),
            fit: BoxFit.fill,
          ),
        ),

    //     appBar: AppBar(
    //       backgroundColor: Colors.transparent,
    //     leading: IconButton(
    //     icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
    // onPressed: () => Navigator.of(context).pop(),
    //   ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[

            Container(
              height: 50,
              alignment: Alignment.topLeft,
              // padding: EdgeInsets.fromLTRB(10, 10, 5, 5),

              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                //padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                icon: Icon(Icons.keyboard_arrow_left,color: Colors.white,),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(30, 5, 5, 5),
              child: Text(
                'Create',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(30, 2, 5, 5),
              child: Text(
                'Account',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              padding: EdgeInsets.only(top: 2.0, left: 20, right: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        activeColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        value: Gender.Male,
                        groupValue: character,
                        onChanged: (Gender value) {
                          setState(() {
                            character = value;
                          });
                        },
                      ),
                      Text(
                        'MALE',
                        style: new TextStyle(fontSize: 17.0,color: Colors.white),
                      ),
                      Radio(
                        activeColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        value: Gender.Female,
                        groupValue: character,
                        onChanged: (Gender value) {
                          setState(() {
                            character = value;
                          });
                        },
                      ),
                      Text(
                        'FEMALE',
                        style: new TextStyle(fontSize: 17.0,color: Colors.white),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: nameController,
                    decoration: InputDecoration(
                      //errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      // border: InputBorder.none,
                      labelText: 'Name',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Form(
                    key: _formKey ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: validateEmail,
                          controller: emailController,
                          decoration: Decor.decorText.copyWith(labelText: 'Email'),

                          // InputDecoration(
                          //
                          //   enabledBorder: UnderlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.white),
                          //   ),
                          //   hintStyle: TextStyle(color: Colors.white),
                          //   labelStyle: TextStyle(color: Colors.white),
                          //   // border: InputBorder.none,
                          //   labelText: 'Email',
                          //   focusedBorder: UnderlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.white),
                          //   ),
                          //
                          // ),

                          keyboardType: TextInputType.emailAddress,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CountryPicker(

                              dialingCodeTextStyle: TextStyle(color: Colors.white),
                              nameTextStyle: TextStyle(color: Colors.white),
                              showDialingCode: true,

                              showName: true,
                              onChanged: (Country country){
                                setState(() {
                                  _selected = country;
                                });
                              },
                              selectedCountry: _selected,
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child:  TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  validator: validateMobile,
                                  decoration: new InputDecoration(hintText: 'Mobile Number',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                  //  labelStyle: TextStyle(color: Colors.white),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  // validator: validateMobile,
                                  onSaved: (String val) {
                                    mobile = val;
                                  }
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onTap: () {
                      _selectDate(context);
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    controller: dateofBirthController,
                    decoration: new InputDecoration(hintText: 'Date of Birth',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: passwordController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // border: InputBorder.none,
                      labelText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        checkColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        //title: Text("title text"),
                        value: eng,
                        onChanged: (newValue) {
                          setState(() {
                            eng = newValue;
                          });
                        },
                        //controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      Text('English',style: TextStyle(color: Colors.white),),
                      Checkbox(

                        checkColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        //title: Text("title text"),
                        value: hindi,
                        onChanged: (newValue) {
                          setState(() {
                            hindi = newValue;
                          });
                        },
                        //controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      Text('Hindi',style: TextStyle(color: Colors.white),),
                      Checkbox(
                        checkColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        // title: Text("title text"),
                        value: guj,
                        onChanged: (newValue) {
                          setState(() {
                            guj = newValue;
                          });
                        },
                        //controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),

                      Text('Gujarati',style: TextStyle(color: Colors.white),),

                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 25.0,color: Colors.white
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 50,
                        height: 50,
                        child:RaisedButton(
                          shape: CircleBorder(),
                          textColor: Colors.white,
                          color: Colors.black54,
                          child: Image.asset("assets/right-arrow.png",width: 20,height: 20,),
                          onPressed: () {
                            final FormState form = _formKey.currentState;
                            if (form.validate()) {
                            //  _loginState(email, password)
                              print('Form is valid');
                              pr.show();
                              _registerState(emailController.text, passwordController.text);
                            } else {
                              print('Form is invalid');
                            }
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
                padding: EdgeInsets.only(bottom: 10.0,left: 10.0,right: 20.0),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                        textColor: Colors.white,
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
            )
          ],
        ),
      ),
    );
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign Up"),
      // ),
      // body: Center(
      //   child: RaisedButton(
      //     onPressed: () {
      //     //  Navigator.pop(context);
      //     },
      //     child: Text('Go back!'),
      //   ),
      // ),
    // );
   // }
// }
