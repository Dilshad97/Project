

import 'package:demoproject/Auth/Login/provider/login_provider.dart';
import 'package:demoproject/home/ui/home_screen.dart';
import 'package:demoproject/utils/locator.dart';
import 'package:demoproject/utils/navigation_const.dart';
import 'package:demoproject/utils/navigation_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Methods {
  void loginUser(String emailcontroller, String passwordcontroller,
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    try {
      if (await loginProvider.loginUser(emailcontroller, passwordcontroller, _scaffoldKey)) {
        locator<NavigationUtil>().pushAndRemoveUntil(context, login);

      }
    } catch (e) {
      print('///Login user failed $e');


    }
  }
}
