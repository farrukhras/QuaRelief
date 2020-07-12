import 'package:flutter/material.dart';
import 'package:health/chatmessages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String _name = "Anonymous";

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmit(String text) {
    _chatController.clear();
    print(text);
    ChatMessage message = new ChatMessage(text: text);
    Firestore.instance.collection("YogaChat").add({
      "message": text,
    });
    // setState(() {
    //   // _messages.insert(0, message);
    // });
  }

  Widget _chatEnvironment() {
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "Starts typing ..."),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
      children: <Widget>[
        new StreamBuilder(
          stream: Firestore.instance.collection("YogaChat").snapshots(),
          // initialData: initialData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Loading....');
            } else {
              return Container(
                child: new Flexible(
                  child: ListView.builder(
                      padding: new EdgeInsets.all(8.0),
                      reverse: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                margin: const EdgeInsets.only(right: 16.0),
                                child: new CircleAvatar(
                                  child: new Image.network(
                                      "http://res.cloudinary.com/kennyy/image/upload/v1531317427/avatar_z1rc6f.png"),
                                ),
                              ),
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(_name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  new Container(
                                    margin: const EdgeInsets.only(top: 5.0),
                                    child: new Text(snapshot
                                        .data.documents[index]["message"]),
                                  )
                                ],
                              )
                            ],
                          )),
                ),
              );
            }
          },
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _chatEnvironment(),
        )
      ],
    ));
  }
}
