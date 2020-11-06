import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset('assets/Images/brain_icon.png', height: 300,)
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.68,
            left: MediaQuery.of(context).size.width * 0.23,
            child: Text("Mirror",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55, color: Colors.white, fontFamily: 'RobotoMono'),),
          ),
          Positioned(
            bottom: 50,
            left: 150,
            child: FloatingActionButton(
              backgroundColor: Colors.grey,
              child: Icon(Icons.power_settings_new),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Modules');
              },
            ),
          )
        ],
      )
    );
  }
}
