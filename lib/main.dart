import 'package:demoproject/Auth/Login/provider/login_provider.dart';
import 'package:demoproject/Auth/signup/provider/sign_up.dart';
import 'package:demoproject/home/ui/home_screen.dart';
import 'package:demoproject/utils/color_constants.dart';
import 'package:demoproject/utils/locator.dart';
import 'package:demoproject/utils/navigation_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Auth/Login/ui/login_screen.dart';
import 'Auth/forget_password/provider/forget_provider.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(
          create: (context) => LoginProvider(),
        ),
        ListenableProvider(
          create: (context) => SignUpProvider(),
        ),
        ListenableProvider(
          create: (context) => ForgetPasswordProvider(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: NavigationUtil().generateRoute,
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
