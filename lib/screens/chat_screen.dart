import 'package:chat_time/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../my_widget/bubble_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  String messageText;
  final _auth = FirebaseAuth.instance;

  final textClear = TextEditingController();

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Theme
                  .of(context)
                  .accentColor,
              Theme
                  .of(context)
                  .primaryColor,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Chat',
              style: TextStyle(color: Colors.amber),
            ),
            // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [
              FlatButton(
                minWidth: 0,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                },
                child: Center(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Icon(
                        Icons.exit_to_app_outlined,
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MessageStream(),

                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 13),
                //     child: ListView(
                //       // crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         BubbleText(
                //           sender: 'Sender@gmail.com',
                //           message: 'Hello',
                //         ),
                //         BubbleText(sender: 'Sender@gmail.com', message: 'Hello',),
                //         BubbleText(sender: 'Sender@gmail.com', message: 'Hello',),
                //         BubbleText(sender: 'Sender@gmail.com', message: 'Hello',),
                //       ],
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textClear,
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 13),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(0)),
                                borderSide: BorderSide.none),
                            hintText: 'Enter a message',
                            filled: true,
                            fillColor: Colors.white54),
                        onChanged: (value) {
                          messageText = value;
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          _firestore.collection('messages').add(
                            {
                              'sender': loggedInUser.email,
                              'text': messageText,
                              'Timestamp': FieldValue.serverTimestamp(),
                            },
                          );
                          textClear.clear();
                          // messageStream();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(20))),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        child: Text(
                          'SEND',
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('Timestamp').snapshots(),
        builder: (context, snapshot) {


          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: MyApp.dark,
              ),
            );
          }else {
            final messages = snapshot.data.docs.reversed;
            List<Widget> messagesWidgets = [];
            for (var message in messages) {
              final messageText = message.get('text');
              final messageSender = message.get('sender');
              final messageWidget = BubbleText(
                sender: messageSender,
                message: messageText,
                isMe: loggedInUser.email == messageSender,);
              messagesWidgets.add(messageWidget);
              print(messageSender);
              print(loggedInUser);
              print(messages);
            }

            // int length = messages.length;
            // for (int i = 0; i < length; i++) {
            //   var message = messages[i];
            //   final messageText = message.get('text');
            //   final messageSender = message.get('sender');
            //   final messageWidget = BubbleText(
            //     sender: messageSender,
            //     message: messageText,
            //     isMe: loggedInUser == messageSender,
            //   );
            //   messagesWidgets.add(messageWidget);
            //   print(messageSender);
            //   print(messages.length);
            //   // break;
            // }

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 13),
                child: ListView(
                  reverse: true,
                  children: messagesWidgets,
                ),
              ),
            );
          }
        });
  }
}
