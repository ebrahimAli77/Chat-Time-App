import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  Function onPress;
  String title;

  Button({@required this.onPress, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: double.infinity,
        child: RaisedButton(
          elevation: 5,
          onPressed: onPress,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Color(0xff782a58),
          child: Text(title, style: TextStyle(color: Colors.white, fontSize: 14),),
        ),
      ),
    );
  }
}
