import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  String _uid;
  String _email;
  String _name;

  String get getUID => _uid;

  String get getEmail => _email;

  String get getName => _name;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> loginUser(
      String emailcontroller, String passwordcontroller) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailcontroller, password: passwordcontroller);

      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        _email = userCredential.user.email;
        _name = userCredential.user.displayName;
        notifyListeners();
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
