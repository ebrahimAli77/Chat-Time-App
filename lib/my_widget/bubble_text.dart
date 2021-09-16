import 'package:chat_time/main.dart';
import 'package:flutter/material.dart';

class BubbleText extends StatelessWidget {
  final String sender;
  final String message;
  bool isMe;

  BubbleText({@required this.sender, @required this.message, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.amber),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              // width: 130,
              decoration: BoxDecoration(
                color: isMe ? MyApp.dark : MyApp.light,
                borderRadius: isMe ? BorderRadius.only(
                  topRight: Radius.circular(1),
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ) : BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(1),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 18, color: isMe ? MyApp.light : MyApp.dark ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
