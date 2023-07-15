import 'package:flutter/material.dart';
import 'package:strawbrew_crew/models/user.dart';
import 'package:strawbrew_crew/services/database.dart';
import 'package:strawbrew_crew/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:strawbrew_crew/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final theuser =
        Provider.of<MyUser?>(context); //buat ngasi uid ke database service

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: theuser!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Update your brew settings',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: _currentName ?? userData?.name,
                      decoration: textInputDecoration,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (value) => setState(() {
                        _currentName = value;
                      }),
                    ),
                    const SizedBox(height: 20.0),
                    //dropdown
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars ?? userData?.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() {
                        _currentSugars = value!;
                      }),
                    ),
                    //slider
                    Slider(
                      value:
                          (_currentStrength ?? userData?.strength)!.toDouble(),
                      activeColor: Colors
                          .brown[(_currentStrength ?? userData?.strength)!],
                      inactiveColor: Colors
                          .brown[(_currentStrength ?? userData?.strength)!],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (value) => setState(() {
                        _currentStrength = value.round();
                      }),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: theuser.uid)
                                .updateUserData(
                                    _currentSugars ?? userData!.sugars,
                                    _currentName ?? userData!.name,
                                    _currentStrength ?? userData!.strength);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink),
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
