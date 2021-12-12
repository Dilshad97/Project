import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  String _uid;
  String _email;
  String _name;

  String get getUID => _uid;

  String get getEmail => _email;

  String get getName => _name;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signup(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        _email = userCredential.user.email;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('///User added failed');
    }
    notifyListeners();
  }
}
