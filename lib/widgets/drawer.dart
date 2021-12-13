import 'package:demoproject/utils/color_constants.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: ColorConstants.red,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.png",
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Eglairance")
                ],
              )),
          Divider(height: 5,color: Colors.red.shade900,thickness: 3,),
          ListTile(
            onTap: () {
              debugPrint("Tapped Profile");
            },
            leading: Icon(Icons.person),
            title: Text(
              "Your Profile",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped settings");
            },
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Payments");
            },
            leading: Icon(Icons.payment),
            title: Text("Payments"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Notifications");
            },
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Log Out");
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Log Out");
            },
            leading: Icon(Icons.share),
            title: Text("Share"),
          ),
          SizedBox(
            height: 120,
          ),
          Align(
              alignment: Alignment.bottomCenter, child: Text('Version 1.0.01'))
        ],
      ),
    );
  }
}
