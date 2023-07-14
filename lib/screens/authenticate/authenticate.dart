import 'package:flutter/material.dart';
import 'package:strawbrew_crew/screens/authenticate/register.dart';
import 'package:strawbrew_crew/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      setState(() {
        //to reverse the value
        showSignIn = !showSignIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggle: toggleView);
    } else {
      return Register(toggle: toggleView);
    }
  }
}
