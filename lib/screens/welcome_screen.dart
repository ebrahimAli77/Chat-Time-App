import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../main.dart';
import '../my_widget/button.dart';
import 'register_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  // Animation animation;
  // AnimationController controller;

  @override
  void initState() {
    super.initState();
    // controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    // controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        child: Image(
                          image: AssetImage(
                            'assets/images/newLogo.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  TyperAnimatedTextKit(
                    speed: Duration(milliseconds: 100),
                    text: ['Chat Time'],
                    textStyle: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: MyApp.light),
                  ),
                ],
              ),
              Button(
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                title: 'Log In',
              ),
              Button(
                onPress: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                title: 'Sign Up',
              ),
              SizedBox(
                height: 15,
              ),
              FloatingActionButton(
                onPressed: () {
                  print('floatingActionPressed');
                  setState(() {
                    if (MyApp.dark == Color(0xff12082d)) {
                      MyApp.dark = Color(0xfff4f0f7);
                      MyApp.light = Color(0xff12082d);
                      // BubbleText.txtColor = Color(0xfff4f0f7);
                    } else if (MyApp.dark == Color(0xfff4f0f7)) {
                      MyApp.dark = Color(0xff12082d);
                      MyApp.light = Color(0xfff4f0f7);
                      // BubbleText.txtColor = Color(0xff12082d);
                    }
                  });
                  // setState(() {
                  //   MyApp.dark ==  Color(0xfff4f0f7) ? MyApp.dark = Color(0xff12082d) : MyApp.light = Color(0xfff4f0f7);
                  // });
                },
                backgroundColor: MyApp.light,
                child: Icon(
                  Icons.switch_left_outlined,
                  color: MyApp.dark,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
