import 'package:flutter/material.dart';
import 'package:strawbrew_crew/services/auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('StrawBrew Crew'),
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
              ))
        ],
      ),
    );
  }
}
