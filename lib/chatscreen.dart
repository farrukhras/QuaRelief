import 'package:flutter/material.dart';
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

  void _handleSubmit(String text) async {
    _chatController.clear();

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

    Firestore.instance
        .collection(widget.text + "Counter")
        .document("messageCounter")
        .updateData({"counter": count + 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
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
                final children1 = <Widget>[];
                for (var message in data) {
                  children1.add(chatData(message.data['message']));
                }
                return Column(
                  children: children1,
                );
              }
            },
          ),
          new Divider(
            height: 1.0,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: _chatEnvironment(_chatController, _handleSubmit),
      ),
    );
  }
}

Widget chatData(message) {
  return Container(
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.fromLTRB(5, 3, 10, 10),
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
              padding: const EdgeInsets.only(top: 8.0),
              child: new Text(_name, style: TextStyle(fontSize: 10)),
            ),
            new Container(
              margin: const EdgeInsets.fromLTRB(0, 2.0, 10, 0),
              child: new Text(
                message,
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget _chatEnvironment(_chatController, _handleSubmit) {
  return IconTheme(
    data: new IconThemeData(color: Colors.blue),
    child: new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              decoration:
                  new InputDecoration.collapsed(hintText: "Starts typing ..."),
              controller: _chatController,
              onSubmitted: _handleSubmit,
            ),
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
