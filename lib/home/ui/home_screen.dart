import 'package:demoproject/utils/color_constants.dart';
import 'package:demoproject/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: AppBar(
          backgroundColor: ColorConstants.red,
        ),
        drawer:CustomDrawer(),

      // drawer: Drawer(child:DrawerFUn()),

          body: Center(
            child: Text("hi I am Homepage"),
          )),
    );
  }
}
