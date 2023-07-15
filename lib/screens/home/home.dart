import 'package:strawbrew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strawbrew_crew/screens/home/brew_list.dart';
import 'package:strawbrew_crew/screens/home/settings_form.dart';
import 'package:strawbrew_crew/services/auth.dart';
import 'package:strawbrew_crew/services/database.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('StrawBrew Coffee'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await _auth.SignOut();
                },
                icon: const Icon(Icons.person, color: Colors.black),
                label: const Text(
                  'logout',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text('settings'),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
            )
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bgcoffee.png'),
                    fit: BoxFit.cover)),
            child: BrewList()),
      ),
    );
  }
}
