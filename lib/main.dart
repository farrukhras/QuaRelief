import 'package:flutter/material.dart';
import 'package:health/home.dart';
import 'package:health/loadingscreen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/home_screen': (context) => Home(),
      },
    ));
