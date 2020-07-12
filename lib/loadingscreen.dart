import 'package:flutter/material.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => new _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  timer() async {
    // call back function. switchScreen is called after 10 seconds
    return Timer(Duration(seconds: 5), switchScreen);
  }

  void switchScreen() {
    Navigator.of(context).pushReplacementNamed('/home_screen');
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return new Scaffold(
      body: Center(
        child: Container(
            height: blockHeight * 100,
            width: blockWidth * 100,
            color: Colors.white,
            child: Align(
                alignment: Alignment(-blockWidth * 0.4, -blockHeight * 0.08),
                child: Image.asset('assets/QuaRelief.png',
                    scale: blockWidth / 15))),
      ),
    );
  }
}
