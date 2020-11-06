


import 'package:flutter/material.dart';
import 'package:flutterapp/Pages/Add_location.dart';
import 'Pages/Home.dart';
import 'Pages/Modules.dart';
import 'Pages/Voice.dart';
import 'Pages/Add_location.dart';
import 'Pages/Add_Stock.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/home': (context) => Home(),
    '/Modules': (context) => Modules(),
    '/Voice': (context) => Voice(),
    '/Location': (context) => Locations(),
    '/Stock': (context) => Stock(),
  },
));
