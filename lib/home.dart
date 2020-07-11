import 'package:flutter/material.dart';
import 'package:health/books.dart';
import 'package:health/dance.dart';
import 'package:health/meditate.dart';
import 'package:health/spirtual.dart';
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
            img1: 'assets/yoga.jpg',
            img2: 'assets/meditate.jpg',
            t1: 'Yoga',
            t2: 'Meditation',
            url1: Yoga(),
            url2: Meditate(),
          ),
          Handler(
            img1: 'assets/dance.jpg',
            img2: 'assets/books.jpg',
            t1: 'Dance',
            t2: 'Books',
            url1: Dance(),
            url2: Books(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Spirtual(),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: blockWidth * 32,
                        width: blockWidth * 32,
                        child: Image.asset(
                          'assets/spirtual.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: blockWidth * 2,
                      ),
                      Text(
                        'Spirtuality',
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
      color: Colors.brown[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: blockWidth * 2),
            child: cHandler(img1, t1, url1),
          ),
          Padding(
            padding: EdgeInsets.only(left: blockWidth * 2),
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
