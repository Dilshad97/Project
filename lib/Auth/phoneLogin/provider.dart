// import 'package:demoproject/utils/locator.dart';
// import 'package:demoproject/utils/navigation_const.dart';
// import 'package:demoproject/utils/navigation_util.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
//
// class AuthService {
//   String _phoneNumber;
//   String _verificationId;
//   String _smsCode;
//   String _message;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   String get phoneNumber1 => _phoneNumber;
//   String get verificationId => _verificationId;
//   String get smsCode => _smsCode;
//   String get message => _message;
//
//
//
//
//
//   Future<void> verifyPhoneNumber(String phoneNumber) async {
//     print(phoneNumber);
//
//     PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential phoneAuthCredential) async {
//       print('User Auto Logged In');
//       UserCredential _userCredential =  await _auth.signInWithCredential(phoneAuthCredential).then((value)async{
//         if(value.user!=null){
//           print('/// User Loged in');
//         }
//         else{
//           return null;
//         }
//       });
//
//
//
//     };
//
//     PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException authException) async {
//       print('Auth Exception Occured');
//       throw Exception(authException.message);
//       // _message =
//       //     'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
//     };
//
//     PhoneCodeSent codeSent =
//         (String verificationId, [int forceResendingToken]) async {
//       print('SMS Sent');
//       _verificationId = verificationId;
//     };
//
//     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) async {
//       print('SMS Auto Retrieval Timeout');
//       _verificationId = verificationId;
//     };
//
//
//
//     await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         timeout: const Duration(seconds: 60),
//         verificationCompleted: verificationCompleted,
//         verificationFailed: verificationFailed,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//   }
//
//   // Example code of how to sign in with phone.
//   void signInWithPhoneNumber(String otpController, BuildContext context) async {
//     final AuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: _verificationId,
//       smsCode: otpController,
//     );
//     final User user = (await _auth.signInWithCredential(credential)).user;
//
//     if(user!=null){
//       locator<NavigationUtil>().pushAndRemoveUntil(context, phonesignup);
//
//     }
//   }
// }

import 'package:demoproject/home/ui/home_screen.dart';
import 'package:demoproject/utils/locator.dart';
import 'package:demoproject/utils/navigation_const.dart';
import 'package:demoproject/utils/navigation_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );
  //
  // final storage = new FlutterSecureStorage();
  // Future<void> googleSignIn(BuildContext context) async {
  //   try {
  //     GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //     await googleSignInAccount.authentication;
  //     AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     if (googleSignInAccount != null) {
  //       UserCredential userCredential =
  //       await _auth.signInWithCredential(credential);
  //       storeTokenAndData(userCredential);
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (builder) => HomePage()),
  //               (route) => false);
  //
  //       final snackBar =
  //       SnackBar(content: Text(userCredential.user.displayName));
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //   } catch (e) {
  //     print("here---->");
  //     final snackBar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }
  //
  // Future<void> signOut({BuildContext context}) async {
  //   try {
  //     await _googleSignIn.signOut();
  //     await _auth.signOut();
  //     await storage.delete(key: "token");
  //   } catch (e) {
  //     final snackBar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }
  //
  // void storeTokenAndData(UserCredential userCredential) async {
  //   print("storing token and data");
  //   await storage.write(
  //       key: "token", value: userCredential.credential.token.toString());
  //   await storage.write(
  //       key: "usercredential", value: userCredential.toString());
  // }
  //
  // Future<String> getToken() async {
  //   return await storage.read(key: "token");
  // }

  Future<void> verifyPhoneNumber(
   String phoneNumber, BuildContext context, Function setData,GlobalKey<ScaffoldState> _scaffoldKey,) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showInSnackBar( "Verification Completed",_scaffoldKey);
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showInSnackBar( exception.toString(),_scaffoldKey,);
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int forceResnedingtoken]) {
      showInSnackBar("Verification Code sent on the phone number",_scaffoldKey, );
      setData(verificationID);
    };




    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showInSnackBar( "Time out",_scaffoldKey);
    };
    try {
      await _auth.verifyPhoneNumber(
          timeout: Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      print("///$e");

      showInSnackBar(e.toString(),_scaffoldKey);
    }
  }

  Future<void> signInwithPhoneNumber(String verificationId, String smsCode, BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {

    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // storeTokenAndData(userCredential);
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (builder) => Home(userCredential.user)),
      //         (route) => false);


      locator<NavigationUtil>().push(context, login,arguments: {

       [ 'data']:userCredential.user
      });

      showInSnackBar( "logged In",_scaffoldKey);
    } catch (e) {
      print("///$e");
      showInSnackBar( e.toString(),_scaffoldKey);
    }
  }

  void showInSnackBar(String value, GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }
}