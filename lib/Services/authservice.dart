import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectomodelo/firebase_options.dart';

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
  //Register in with email y password

  //Sign out
}
