import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  String _uid;
  String _email;

  String get getUID => _uid;

  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signup(String email, String password, String firstnamecontroller,
      String lastnamecontroller, String emailcontroller) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        _email = userCredential.user.email;
        CollectionReference reference =
            FirebaseFirestore.instance.collection('user');
        await reference
            .doc(getUID)
            .set({
              'firstname': firstnamecontroller,
              'lastname': lastnamecontroller,
              'email': emailcontroller,
              'image': 'image'
            })
            .then((value) => print("/// user save to firebase"))
            .catchError((error) => print("///user added failed to firebase$error"));
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('///User added failed$e');
    }
    notifyListeners();
  }
}
