import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class list_users extends StatefulWidget {
  list_users({Key key}) : super(key: key);
  @override
  _ListUsersPage createState() => _ListUsersPage();
}
class _ListUsersPage extends State<list_users> {
  Autogenerated model = new Autogenerated();
  List data;

  void initState() {
    super.initState();
    this._getUsers();
  }
  Future  _getUsers() async {
    var response= await http.get("https://reqres.in/api/users?page=2");
    print(response.body);
    Map userMap = jsonDecode(response.body);
    var user = Autogenerated.fromJson(userMap);
    model = user;
    print(user.page);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['data'];

    });
    //Model _model = AutoGenerated.
    // var jsonData = ;
    // List<Data> users = [];
    //
    // for (var u in jsonData){
    //   Data user = Data(u["email"], u["first_name"]);
    //   users.add(user);
    // }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('List Users'),
      ),
      body: ListView.builder(
          itemCount: model.data.length,
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(model.data[index].avatar),
              ),
              title: Text(model.data[index].firstName),
              subtitle: Text(model.data[index].email),
              // child: Column(
              //   children: <Widget>[
              //     Card(
              //       child: Container(
              //         child: Text(data[index]['email']),
              //         padding: const EdgeInsets.all(20),
              //       ),
              //     ),
              //   ],
              // ),
            );
          }
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