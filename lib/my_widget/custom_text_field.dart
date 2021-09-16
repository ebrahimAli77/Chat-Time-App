import 'package:chat_time/main.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {

  String title;
  IconData icon;
  bool isSecure;
  Function onChanged;
  var keyboardType;

  CustomTextField({@required this.title,@required this.icon,@required this.isSecure, this.onChanged, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: MyApp.light),
        obscureText: isSecure,
        autofocus: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
            borderRadius: BorderRadius.circular(2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding:
          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          filled: false,
          fillColor:  Color(0xff782a58),
          hintStyle: TextStyle(color: Colors.amber.withOpacity(0.4)),
          hintText: title,
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.amber),
          //   borderRadius: BorderRadius.circular(30),
          // ),
          icon: Icon(icon,color: Theme.of(context).accentColor,),
        ),
        onChanged: onChanged,
        keyboardType: keyboardType,
      ),
    );
  }
}
