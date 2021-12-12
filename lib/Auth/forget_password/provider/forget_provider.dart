import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ForgetPasswordProvider extends ChangeNotifier{



  FirebaseAuth _auth =FirebaseAuth.instance;
  Future<void> resetPassword( resetPasswordController)async{
    try{
      await _auth.sendPasswordResetEmail(email: resetPasswordController);
    }on FirebaseException catch(e){
      print('/// Error password reset  mail not send$e');
    }
    notifyListeners();
  }
}