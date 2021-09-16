import '../main.dart';
import '../my_widget/custom_text_field.dart';
import '../my_widget/button.dart';
import '../screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_Screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;

  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyApp.dark,
        body: ModalProgressHUD(
          color: MyApp.dark,
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 200,
                          child: Image(
                            image: AssetImage('assets/images/newLogo.png'),
                          )),
                    ),
                  ),
                ),
                Center(
                  child: ColorizeAnimatedTextKit(
                    repeatForever: true,
                    speed: Duration(milliseconds: 400),
                    text: ['LOG IN',
                    'TO CHAT'],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                      Colors.amber
                      // Color(0xff12082d),
                    ],
                    textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: MyApp.light),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  title: 'Email',
                  icon: Icons.email_outlined,
                  isSecure: false,
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextField(
                  title: 'Password',
                  icon: Icons.keyboard_control_rounded,
                  isSecure: true,
                  onChanged: (value) {
                    password = value;
                  },
                  keyboardType: TextInputType.visiblePassword,),
                SizedBox(
                  height: 30,
                ),
                Button(
                    onPress: () async{
                      setState(() {
                        showSpinner = true;
                      });
                      try{
                        final alreadyUser = await _auth.signInWithEmailAndPassword(email:email,password: password);
                        if (alreadyUser != null ){
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      }catch(e){
                        print(e);
                      }
                    },
                    title: 'Log In'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
