import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class CommunityScreen extends StatefulWidget {

  static const String id = "CommunityScreen";

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  TextEditingController messageController = new TextEditingController();
  final _firestore = Firestore.instance;
  List<MessageBubble> messageBubbles = [];
  String messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Community'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('community_messages').snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
                final messages = snapshot.data.documents;
                messageBubbles = [];
                for(var message in messages) {
                  final messageText = message.data['message_text'];
                  print(messageText);
                  final messageBubble = MessageBubble(
                    messageText: messageText,
                  );
                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageBubbles,
                  ),
                );
              },
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(7.0),
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Type your question?',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageController.clear();
                      _firestore.collection('community_messages').add({
                        'message_text': messageText,
                      });
                    },
                    child: Text(
                      'Send',
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
