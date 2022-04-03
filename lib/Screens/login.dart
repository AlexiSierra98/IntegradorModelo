import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyectomodelo/Services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();

  AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            TextFormField(onChanged: (val) {
              setState(() => email = val);
            }),
            SizedBox(
              height: 50,
            ),
            TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  /*
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    print('Error');
                  } else {
                    print('sign in');
                    Navigator.of(context).pushNamed('/second');
                  }
                  print(email);
                  print(password);
                  */

                  try {
                    UserCredential credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);
                    Navigator.of(context).pushNamed('/second');
                  } catch (e) {
                    print(e.toString());
                    return null;
                  }
                })
          ],
        ),
      ),
    );
  }
}
