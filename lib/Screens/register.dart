import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectomodelo/Services/authservice.dart';
import 'package:proyectomodelo/Services/model_usuario.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final _formKey = GlobalKey<FormState>();
  DataBService _db = DataBService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailcontroller = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoPController = TextEditingController();
  final apellidoMController = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            TextFormField(
                autofocus: false,
                controller: nombreController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                ),
                onSaved: (value) {
                  nombreController.text = value!;
                }),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                autofocus: false,
                controller: apellidoPController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'Apellido Paterno',
                ),
                onSaved: (value) {
                  apellidoPController.text = value!;
                }),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                autofocus: false,
                controller: apellidoMController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'Apellido Materno',
                ),
                onSaved: (value) {
                  apellidoMController.text = value!;
                }),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                autofocus: false,
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Correo institucional',
                ),
                onSaved: (value) {
                  emailcontroller.text = value!;
                }),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                autofocus: false,
                controller: passwordcontroller,
                keyboardType: TextInputType.name,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'contraseña',
                ),
                onSaved: (value) {
                  passwordcontroller.text = value!;
                }),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                autofocus: false,
                controller: confirmpasswordcontroller,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'confirmar contraseña',
                ),
                onSaved: (value) {
                  confirmpasswordcontroller.text = value!;
                }),
            ElevatedButton(
                child: Text(
                  'Registrar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  registerAcc(emailcontroller.text, passwordcontroller.text);
                }),
          ],
        ),
      ),
    );
  }

  void registerAcc(emailcontroller,passwordcontroller) async{
    try {
      await _auth
          .createUserWithEmailAndPassword(email: emailcontroller, password: passwordcontroller)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
      });
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
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore _db = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.Nombre = nombreController.text;
    userModel.ApellidoPaterno = apellidoPController.text;
    userModel.ApellidoMaterno = apellidoMController.text;



    await _db
        .collection("users")
        .doc(user.email)
        .set(userModel.toMap());
  }
}
