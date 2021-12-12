import 'package:demoproject/Auth/signup/provider/sign_up.dart';
import 'package:demoproject/utils/locator.dart';
import 'package:demoproject/utils/navigation_const.dart';
import 'package:demoproject/utils/navigation_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupMethod {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void signup(String email, String password, BuildContext context) async {
    SignUpProvider signUpProvider =
        Provider.of<SignUpProvider>(context, listen: false);
    try {
      if (await signUpProvider.signup(email, password)) {
        locator<NavigationUtil>().push(context, login);
      }
    } catch (e) {
      print('///User SignUp Failed');
    }
  }


  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }


}
