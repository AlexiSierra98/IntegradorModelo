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
      backgroundColor: Color(0xff6f00ff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                this._logoTexto(),
                this.__formularioLogin(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoTexto() {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(
                0, size.height * 0.12, 0, size.height * 0.02),
            child: Image.asset(
              'assets/logos/logotipo.png',
              scale: size.height * 0.0035,
            ),
          ),
        ),
        Text(
          'Bienvenido',
          style: TextStyle(
              fontSize: size.height * 0.030,
              fontFamily: 'Futura',
              color: Colors.white),
        ),
      ],
    );
  }

  Widget __formularioLogin() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.45),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(size.height * 0.05,
                  size.height * 0.02, size.height * 0.05, 0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    fontSize: size.height * 0.018, color: Colors.white),
                onSaved: (value) {
                  emailController.text = value!;
                },
                decoration: new InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: size.height * 0.018, color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  label: Text('Correo Institucional'),
                  labelStyle: TextStyle(
                      fontSize: size.height * 0.018, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(size.height * 0.05,
                  size.height * 0.02, size.height * 0.05, size.height * 0.05),
              child: TextFormField(
                autofocus: false,
                controller: passwordController,
                obscureText: true,
                style: TextStyle(
                    fontSize: size.height * 0.018, color: Colors.white),
                onSaved: (value) {
                  passwordController.text = value!;
                },
                decoration: new InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: size.height * 0.018, color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  label: Text('Contraseña'),
                  labelStyle: TextStyle(
                      fontSize: size.height * 0.018, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(
                        size.height * 0.03,
                        size.height * 0.01,
                        size.height * 0.03,
                        size.height * 0.01),
                    primary: Colors.white,
                    onPrimary: Color(0xff6f00ff),
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    'Ingresar',
                    style: TextStyle(
                      fontSize: size.height * 0.030,
                      fontFamily: 'Futura',
                      color: Color(0xff6f00ff),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
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
                    } catch (e) {}
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.05),
              child: Column(
                children: <Widget>[
                  Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(
                        fontSize: size.height * 0.018, color: Colors.white),
                  ),
                  FlatButton(
                    textColor: Colors.white,
                    child: Text(
                      'Registrate',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        fontSize: size.height * 0.018,
                        fontFamily: 'Futura',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
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
    */