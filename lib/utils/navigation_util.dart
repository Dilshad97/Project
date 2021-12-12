import 'package:demoproject/Auth/signup/ui/sign_up_screen.dart';
import 'package:demoproject/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation_const.dart';

class NavigationUtil {
  Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic> arg = settings.arguments;
    switch (settings.name) {
      case login:
        return CupertinoPageRoute(builder: (context) => Home());
      case signup:
        return CupertinoPageRoute(
          builder: (context) => SignUp(),
        );
      default:
        return _errorRoute("Coming soon");
    }
  }

  Future<dynamic> push(BuildContext context, String routeName,
      {Object arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text(message)));
    });
  }
}
