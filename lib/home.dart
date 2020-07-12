import 'package:flutter/material.dart';
import 'package:health/books.dart';
import 'package:health/dance.dart';
import 'package:health/mental.dart';
import 'package:health/yoga.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Material(
      color: Colors.brown[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Handler(
            img1: 'assets/mental_health_1.png',
            img2: 'assets/no_porn_1.png',
            t1: 'MentalHealth',
            t2: 'Pornography',
            url1: Mental(),
            url2: Yoga(),
          ),
          Handler(
            img1: 'assets/yoga_1.png',
            img2: 'assets/books_1.png',
            t1: 'Yoga',
            t2: 'Books',
            url1: Yoga(),
            url2: Books(),
          ),
          Row(
            // Pornography Hnadler
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Colors.brown[100],
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dance(),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: blockWidth * 32,
                        width: blockWidth * 32,
                        child: Image.asset(
                          'assets/dance_1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: blockWidth * 2,
                      ),
                      Text(
                        'Dance',
                        style: TextStyle(
                          fontSize: blockWidth * 5.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Handler extends StatelessWidget {
  final img1, img2, t1, t2, url1, url2;

  Handler(
      {Key key, this.img1, this.img2, this.t1, this.t2, this.url1, this.url2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Material(
      color: Colors.brown[100], // changes row color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: blockWidth * 3),
            child: cHandler(img1, t1, url1),
          ),
          Padding(
            padding: EdgeInsets.only(left: blockWidth * 3),
            child: cHandler(img2, t2, url2),
          ),
        ],
      ),
    );
  }
}

Widget cHandler(img, tex, url) {
  return Builder(builder: (BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Card(
      color: Colors.brown[100],
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => url,
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Container(
              height: blockWidth * 32,
              width: blockWidth * 32,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: blockWidth * 2,
            ),
            Text(
              tex,
              style: TextStyle(
                fontSize: blockWidth * 5.5,
              ),
            ),
          ],
        ),
      ),
    );
  });
}
