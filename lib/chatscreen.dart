// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:health/chatmessages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String _name = "Anonymous";

class ChatScreen extends StatefulWidget {
  final String text;
  ChatScreen({this.text});

  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmit(String text) async {
    _chatController.clear();
    // print(text);
    // ChatMessage message = new ChatMessage(text: text);
    var count = -1;
    await Firestore.instance
        .collection(widget.text + "Counter")
        .document("messageCounter")
        .get()
        .then((DocumentSnapshot ds) {
      count = ds["counter"];
    });

    Firestore.instance.collection(widget.text).add(
        {"message": text, "date": DateTime.now().toIso8601String().toString()});

    // Firestore.instance
    //     .collection(widget.text)
    //     .document(count.toString())
    //     .setData({
    //   "message": text,
    // });

    Firestore.instance
        .collection(widget.text + "Counter")
        .document("messageCounter")
        .updateData({"counter": count + 1});
  }

  Widget ChatData(message) {
    return Container(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
            child: new CircleAvatar(
              child: Image.asset(
                'assets/chat_bot.png',
              ),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: new Text(_name, style: TextStyle(fontSize: 10)),
              ),
              new Container(
                margin: const EdgeInsets.fromLTRB(0, 5.0, 10, 0),
                child: new Text(
                  message,
                  // snapshot.data.documents[index]
                  //     ["message"],
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _chatEnvironment() {
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        // alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              // child: SizedBox(
              // height: 40,
              // width: 150,
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "Starts typing ..."),
                controller: _chatController,
                onSubmitted: _handleSubmit,
              ),
              // ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _handleSubmit(_chatController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
      children: <Widget>[
        new StreamBuilder(
          stream: Firestore.instance
              .collection(widget.text)
              .orderBy("date")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Loading...');
            } else {
              final data = snapshot.data.documents;
              // print(data);
              final children1 = <Widget>[];
              for (var message in data) {
                children1.add(ChatData(message.data['message']));
              }
              return new ListView(
                shrinkWrap: true,
                children: children1,
              );

              // return ListView.builder(
              //   itemCount: data == null ? 0 : data.length,
              //   itemBuilder: (context, index) => Container(
              //     child: new Flexible(
              //       child: ListView.builder(
              //           padding: new EdgeInsets.fromLTRB(10, 0, 0, 10),
              //           reverse: true,
              //           itemCount: snapshot.data.documents.length,
              //           itemBuilder: (context, index1) => new Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: <Widget>[
              //                   new Container(
              //                     margin:
              //                         const EdgeInsets.fromLTRB(0, 0, 10, 10),
              //                     child: new CircleAvatar(
              //                       child: Image.asset(
              //                         'assets/chat_bot.png',
              //                       ),
              //                     ),
              //                   ),
              //                   new Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: <Widget>[
              //                       Padding(
              //                         padding: const EdgeInsets.only(top: 5.0),
              //                         child: new Text(_name,
              //                             style: TextStyle(fontSize: 10)),
              //                       ),
              //                       new Container(
              //                         margin: const EdgeInsets.fromLTRB(
              //                             0, 5.0, 10, 0),
              //                         child: new Text(
              //                           data[index]["message"],
              //                           // snapshot.data.documents[index]
              //                           //     ["message"],
              //                           style: TextStyle(fontSize: 15),
              //                         ),
              //                       )
              //                     ],
              //                   )
              //                 ],
              //               )),
              //     ),
              //   ),
              // );
            }
          },
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          alignment: Alignment.bottomCenter,
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _chatEnvironment(),
        )
      ],
    ));
  }
}
