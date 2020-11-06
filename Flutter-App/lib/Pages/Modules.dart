import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class Modules extends StatefulWidget {
  @override
  _ModulesState createState() => _ModulesState();
}



class _ModulesState extends State<Modules> {
  Color color;
  Color color2;
  IconData icons;
  IconData icons2;
  Color color3;
  Color color4;
  IconData icons3;
  IconData icons4;
  Color color5;
  IconData icons5;
  TextEditingController _textFieldController = TextEditingController();
  List<String> locations = [];
  List<String> Stocks = [];


  void get_current_list() async {
    String url3 = "http://192.168.0.13:5000/time_commute_list";
    http.Response response3  = await http.get(url3);
    if (response3.statusCode == 200) {
      Map values = jsonDecode(response3.body);
      int commute_length = values["commutes"].length;
      if (commute_length != 0) {
        for (int i = 0; i < commute_length; i++) {
          locations.add(values["commutes"][i]["name"]);
        }
      }
      else {
        locations = [];
      }
    }
    else {
      throw Exception('Failed to get Data');
    }
  }

  void get_stock_list() async {
    String url4 = "http://192.168.0.13:5000/stock_list";
    http.Response response4  = await http.get(url4);
    if (response4.statusCode == 200) {
      Map values2 = jsonDecode(response4.body);
      int stock_list = values2["Stock"].length;
      if (stock_list != 0) {
        for (int i = 0; i < stock_list; i++) {
          Stocks.add(values2["Stock"][i]["stock_name"]);
        }
      }
      else {
        Stocks = [];
      }
    }
    else {
      throw Exception('Failed to get data');
    }
  }

  void time_module_change(String mode) async {
    var url = "http://192.168.0.13:5000/24_hour_post";
    var body = json.encode({"time_mode":mode});
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    if (response.statusCode == 200) {
      print("Success");
    }
    else {
      throw Exception('Failed Post');
    }
  }



  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Calendar_id',style: TextStyle(fontFamily: 'RobotMono'),),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Enter Calendar_id"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    color = Colors.redAccent;
    color2 = Colors.redAccent;
    color3 = Colors.redAccent;
    color4 = Colors.redAccent;
    color5 = Colors.redAccent;
    icons = Icons.do_not_disturb_alt;
    icons2 = Icons.do_not_disturb_alt;
    icons3 = Icons.do_not_disturb_alt;
    icons4 = Icons.do_not_disturb_alt;
    icons5 = Icons.do_not_disturb_alt;
    get_current_list();
    get_stock_list();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Modules",
          style:
              TextStyle(fontFamily: 'RobotoMono', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          ExpansionTile(
            title: Text(
              "Time",
              style: TextStyle(
                  fontSize: 25, fontFamily: 'RobotoMono', color: Colors.black),
            ),
            leading: Icon(
              Icons.access_time,
              color: Colors.black,
            ),
            children: <Widget>[
              Container(
                color: color,
                child: ListTile(
                  title: Text(
                    '24 Hour Time',
                    style: TextStyle(fontFamily: 'RobotoMono',fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  leading: Icon(
                    icons,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      if (color == Colors.greenAccent){
                        //Should send a post request here to turn off 24 hour Mode:
                        time_module_change("OFF");
                        color = Colors.redAccent;
                        icons = Icons.do_not_disturb_alt;
                      }
                      else {
                        //Should send a post request here to turn on 24 hour Mode:
                        time_module_change("ON");
                        color = Colors.greenAccent;
                        icons = Icons.check;
                        icons = Icons.check;
                      }
                    });
                  },
                  dense: true,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Calendar",
              style: TextStyle(
                  fontSize: 25, fontFamily: 'RobotoMono', color: Colors.black),
            ),
            leading: Icon(
              Icons.calendar_today,
              color: Colors.black,
            ),
            children: <Widget>[
              Container(
                child: ListTile(
                  title: Text(
                    'Calendar_Id',
                    style: TextStyle(fontFamily: 'RobotoMono',fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  leading: Icon(
                    Icons.perm_identity,
                    color: Colors.black
                  ),
                  onTap: ()=> _displayDialog(context),
                  dense: true,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Time to Commute",
              style: TextStyle(
                  fontSize: 25, fontFamily: 'RobotoMono', color: Colors.black),
            ),
            leading: Icon(
              Icons.time_to_leave,
              color: Colors.black,
            ),
            children: <Widget>[
              Container(
                child: ListTile(
                  title: Text(
                    'Add Location',
                    style: TextStyle(fontFamily: 'RobotoMono',fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  leading: Icon(
                      Icons.place,
                      color: Colors.black
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/Location', arguments: {"Location": locations});
                  },
                  dense: true,
                ),
              ),
            ],
          ),

          ExpansionTile(
            title: Text(
              "Stocks",
              style: TextStyle(
                  fontSize: 25, fontFamily: 'RobotoMono', color: Colors.black),
            ),
            leading: Icon(
              Icons.attach_money,
              color: Colors.black,
            ),
            children: <Widget>[
              Container(
                child: ListTile(
                  title: Text(
                    'Add New Stock',
                    style: TextStyle(fontFamily: 'RobotoMono',fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  leading: Icon(
                      Icons.monetization_on,
                      color: Colors.black
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/Stock', arguments: {"Stocks": Stocks});
                  },
                  dense: true,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Gestures",
              style: TextStyle(
                  fontSize: 25, fontFamily: 'RobotoMono', color: Colors.black),
            ),
            leading: Icon(
              Icons.gesture,
              color: Colors.black,
            ),
            children: <Widget>[
              Container(
                color: color4,
                child: ListTile(
                  title: Text(
                    'Enable Gesture Recognition',
                    style: TextStyle(fontFamily: 'RobotoMono',fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  leading: Icon(
                    icons4,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      if (color4 == Colors.greenAccent){
                        color4 = Colors.redAccent;
                        icons4= Icons.do_not_disturb_alt;
                      }
                      else {
                        color4 = Colors.greenAccent;
                        icons4 = Icons.check;
                        icons4 = Icons.check;
                      }
                    });
                  },
                  dense: true,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Voice",
              style: TextStyle(
                  fontSize: 25, fontFamily: 'RobotoMono', color: Colors.black),
            ),
            leading: Icon(
              Icons.keyboard_voice,
              color: Colors.black,
            ),
            children: <Widget>[
              Container(
                color: color5,
                child: ListTile(
                  title: Text(
                    'Enable Voice Recognition',
                    style: TextStyle(fontFamily: 'RobotoMono',fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  leading: Icon(
                    icons5,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      if (color5 == Colors.greenAccent){
                        color5 = Colors.redAccent;
                        icons5= Icons.do_not_disturb_alt;
                      }
                      else {
                        color5 = Colors.greenAccent;
                        icons5 = Icons.check;
                        icons5 = Icons.check;
                      }
                    });
                  },
                  dense: true,
                ),
              ),
              ListTile(
                title: Text("Enter Voice Command",style: TextStyle(fontFamily: 'RobotoMono',fontWeight: FontWeight.bold, fontSize: 15),),
                leading: Icon(
                  Icons.record_voice_over,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/Voice');
                },
              )
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
