import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

List vid = [
  {
    "name": "Yoga Video Link 1",
    "url": "https://www.youtube.com/watch?v=icfwMWYDeac",
  },
  {
    "name": "Yoga Video Link 1",
    "url": "https://www.youtube.com/watch?v=DO9UkpRl6wM",
  },
];

List tex = [
  {
    "name": "Yoga Text Link 1",
    "url": "https://www.yogajournal.com/poses/poses-by-level/beginners-poses",
  },
  {
    "name": "Yoga Text Link 1",
    "url": "https://www.verywellfit.com/simple-yoga-exercises-3567193",
  },
];

class Meditate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Material(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'Meditate',
                style: TextStyle(
                  fontSize: blockWidth * 7.5,
                  color: Colors.white,
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Video",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: blockWidth * 6,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Text",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: blockWidth * 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: vid == null ? 0 : vid.length,
                itemBuilder: (BuildContext context, int index) {
                  Map elem = vid[index];
                  return YogaSetup(
                    name: elem['name'],
                    url: elem['url'],
                  );
                },
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: tex == null ? 0 : tex.length,
                itemBuilder: (BuildContext context, int index) {
                  Map elem = tex[index];
                  return YogaSetup(
                    name: elem['name'],
                    url: elem['url'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YogaSetup extends StatelessWidget {
  final name, url;
  YogaSetup({Key key, this.name, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: blockWidth * 2),
            child: Text(
              name,
              style: TextStyle(
                fontSize: blockWidth * 4.5,
                color: Color(0xffbb5e1e),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _launchURL(url);
            },
            icon: Icon(Icons.keyboard_arrow_right),
            // color: Colors.red[200],
          ),
        ],
      ),
    );
  }
}

_launchURL(myurl) async {
  var url = myurl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
