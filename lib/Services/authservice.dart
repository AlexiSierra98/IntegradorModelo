import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectomodelo/firebase_options.dart';
import 'package:flutter/material.dart';

import 'model_usuario.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign in anon

  Future signInAnon() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      User user = userCredential.user!;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email y password

Future sigInEP(emailController, passwordController) async{
  try {
    await _auth.signInWithEmailAndPassword(email: emailController, password: passwordController);
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
}
  //Sign out
}

class DataBService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future registerAcc(emailcontroller,passwordcontroller,nombreController,apellidoPController,apellidoMController) async{
    try {
      await _auth
          .createUserWithEmailAndPassword(email: emailcontroller, password: passwordcontroller)
          .then((value) => {postDetailsToFirestore(nombreController,apellidoPController,apellidoMController)})
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

  Future postDetailsToFirestore(firstController,apellidoPController,apellidoMController) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore _db = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.Nombre = firstController.text;
    userModel.ApellidoPaterno = apellidoPController.text;
    userModel.ApellidoMaterno = apellidoMController.text;



    await _db
        .collection("users")
        .doc(user.email)
        .set(userModel.toMap());
  }
}