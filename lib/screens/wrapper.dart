import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strawbrew_crew/models/user.dart';
import 'package:strawbrew_crew/screens/authenticate/authenticate.dart';
import 'package:strawbrew_crew/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final theuser = Provider.of<MyUser?>(context);
    print(theuser);

    //return either home or authenticate widget
    if (theuser == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
