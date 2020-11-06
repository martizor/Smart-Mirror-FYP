import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Locations extends StatefulWidget {
  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  List<String> litems = [];
  String initial_location = "9 Cabinda Drive Keysborough";
  String apiKey = "AIzaSyBzvvThTFkeDDcgk_sjgiNWi23kg1wYtF4";
  int time_seconds;
  Map data = {};




  void distance_calculation_Add(String final_location) async {
    String url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$initial_location&destinations=$final_location&mode=driving&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    time_seconds = values["rows"][0]["elements"][0]["duration"]["value"];
    var url2 = "http://192.168.0.13:5000/time_commute";
    var body = json.encode({"name":final_location,"time":time_seconds});
    var response2 = await http.post(url2, headers: {"Content-Type": "application/json"},body: body);
    if (response2.statusCode == 200) {
      print("Successful Add");
    }
    else {
      throw Exception('Failed Post');
    }
  }

  void remove_place(String location) async {
    var url = "http://192.168.0.13:5000/delete_time_commute";
    var body = json.encode({"name":location});
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    if (response.statusCode == 200) {
      print("Successful Delete");
    }
    else {
      throw Exception('Failed to Delete');
    }
  }



  final TextEditingController eCtrl = new TextEditingController();
  @override
  Widget build (BuildContext ctxt) {
    data = ModalRoute.of(context).settings.arguments;
    litems = data["Location"];
    return new Scaffold(
        appBar: new AppBar(title: new Text("Locations",
        style: TextStyle(
          fontFamily: 'Robotomono'
        ),),
        backgroundColor: Colors.black,
        centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pushReplacementNamed(context, '/Modules')
          ),),
        body: new Column(
          children: <Widget>[
            new TextField(
              controller: eCtrl,
              decoration: InputDecoration(hintText: "Enter Location"),
              onSubmitted: (text) {
                litems.add(text);
                eCtrl.clear();
                setState(() {
                  distance_calculation_Add(text);
                });
              },
            ),
            new Expanded(
                child: new ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: litems.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = litems[index];

                    return Dismissible(
                      key: Key(item),
                      // Provide a function that tells the app
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() {
                          remove_place(litems[index]);
                          litems.removeAt(index);
                        });
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("$item dismissed")));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(color: Colors.red),
                      child: ListTile(title: Text('$item',
                      style: TextStyle(
                        fontFamily: 'Robotomono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
            )
          ],
        )
    );
  }
}