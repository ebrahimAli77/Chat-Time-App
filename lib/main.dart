import './screens/chat_screen.dart';
import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
  Firebase.initializeApp();
}

class MyApp extends StatelessWidget {


  static Color dark = Color(0xff12082d);
  static Color light =  Color(0xfff4f0f7);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: dark,
        primaryColor: Color(0xff3f2552),
        accentColor: Color(0xff732a57),

      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        RegisterScreen.id : (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
