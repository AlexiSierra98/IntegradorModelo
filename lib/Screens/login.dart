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

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                emailController.text = value!;
              },
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              autofocus: false,
              controller: passwordController,
              obscureText: true,
              onSaved: (value) {
                passwordController.text = value!;
              },
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  try {
                    await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                    Navigator.of(context).pushNamed('/home');
                    print(emailController.text);
                    print(passwordController.text);
                  } on FirebaseAuthException catch (error) {
                    switch (error.code) {
                      case "invalid-email":
                        "Your email address appears to be malformed.";
                        break;
                      case "wrong-password":
                        "Your password is wrong.";
                        break;
                      case "user-not-found":
                        "User with this email doesn't exist.";
                        break;
                      case "user-disabled":
                        "User with this email has been disabled.";
                        break;
                      case "too-many-requests":
                        "Too many requests";
                        break;
                      case "operation-not-allowed":
                        "Signing in with Email and Password is not enabled.";
                        break;
                      default:
                        "An undefined Error happened.";
                    }
                    print(error.code);
                  } catch (e) {

                  }
                }),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                })
          ],
        ),
      ),
    );
  }
}
