import 'package:flutter/material.dart';
import 'package:health/chatscreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Material(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            // color:
            backgroundColor:
                Color(int.parse('#345351'.replaceAll('#', '0xff'))),
            title: Center(
              child: Text(
                'Dance',
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
                    "Articles",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: blockWidth * 6,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Chat",
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
              new StreamBuilder(
                  stream: Firestore.instance
                      .collection("DanceYoutubeLinks")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('Loading...');
                    } else {
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          // Map elem = snapshot.data.documents[index];
                          return DanceSetup(
                            name: snapshot.data.documents[index]['name'],
                            url: snapshot.data.documents[index]['url'],
                          );
                        },
                      );
                    }
                  }),
              new StreamBuilder(
                  stream: Firestore.instance
                      .collection("DanceArticlesLinks")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('Loading...');
                    } else {
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          // Map elem = snapshot.data.documents[index];
                          return DanceSetup(
                            name: snapshot.data.documents[index]['name'],
                            url: snapshot.data.documents[index]['url'],
                          );
                        },
                      );
                    }
                  }),
              // CHAT VIEW
              ChatScreen(text: "DanceChat")
              // CHAT VIEW END
            ],
          ),
        ),
      ),
    );
  }
}

class DanceSetup extends StatelessWidget {
  final name, url;
  DanceSetup({Key key, this.name, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: blockWidth * 2),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: blockWidth * 4.5,
                  color: Color(int.parse('#345351'.replaceAll('#', '0xff'))),
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
