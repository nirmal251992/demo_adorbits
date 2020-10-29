import 'package:demo_adorebits/constant.dart';
import 'package:demo_adorebits/user_details.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:connectivity/connectivity.dart';
class list_users extends StatefulWidget {
  list_users({Key key}) : super(key: key);
  @override
  _ListUsersPage createState() => _ListUsersPage();
}
class _ListUsersPage extends State<list_users> {
  Autogenerated model = new Autogenerated();
  List data;
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _connectionStatus = result.toString();
          print(_connectionStatus);
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            setState(() {});
          }
        });
  }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  Future _getUsers() async {
    var response= await http.get("https://reqres.in/api/users?page=2");
    print(response.body);
    var result = jsonDecode(response.body);
    return result;
  }
  @override
  Widget build(BuildContext context) {
   // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Connected')));
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('List Users'),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage:  AssetImage("assets/placheholder.jpg")
                  ),
                  Text('Hello'),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body:

      FutureBuilder(
        future: _getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
           var model = Autogenerated.fromJson(snapshot.data);
            return new ListView.builder(
              itemBuilder: (context, index) => new
              ListTile(
                onTap: () {
                print('On Tap');
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Userdetails(data1: model.data[index],)));
            },
             leading: CircleAvatar(
               backgroundImage: NetworkImage(model.data[index].avatar),
             ),
                title: Text(model.data[index].firstName),
                subtitle: Text(model.data[index].email),
              ),
              itemCount: model.data.length,
            );
          } else {
            return Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
class Autogenerated {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Data> data;
  Ad ad;

  Autogenerated(
      {this.page,
        this.perPage,
        this.total,
        this.totalPages,
        this.data,
        this.ad});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    ad = json['ad'] != null ? new Ad.fromJson(json['ad']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.ad != null) {
      data['ad'] = this.ad.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Data({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Ad {
  String company;
  String url;
  String text;
  Ad({this.company, this.url, this.text});
  Ad.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    url = json['url'];
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}