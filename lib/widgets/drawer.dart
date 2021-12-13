import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoproject/Auth/signup/provider/sign_up.dart';
import 'package:demoproject/utils/color_constants.dart';
import 'package:demoproject/utils/locator.dart';
import 'package:demoproject/utils/navigation_const.dart';
import 'package:demoproject/utils/navigation_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    SignUpProvider provider =
        Provider.of<SignUpProvider>(context, listen: false);
    CollectionReference reference =
        FirebaseFirestore.instance.collection('user');
    String documentId = FirebaseAuth.instance.currentUser.uid;

    return Container(
      color: ColorConstants.red,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: FutureBuilder<DocumentSnapshot>(
          future: reference.doc(documentId).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something Went Wrong");
            }
            if (snapshot.hasData && !snapshot.data.exists) {
              return Text("Data Doesnot Exist");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.red),
                    accountName: Text(
                      data['firstname'] + ' ' + data['lastname'],
                      style: TextStyle(fontSize: 20),
                    ),
                    accountEmail: Text(data['email']),
                    currentAccountPicture: CircleAvatar(
                      radius: 40,
                      child: Text(
                        data['firstname'].substring(0, 1).toUpperCase(),
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
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
                      SignOut(context);
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
                      alignment: Alignment.bottomCenter,
                      child: Text('Version 1.0.01'))
                ],
              );
            }
            return Center(child: Text("Loading"));
          }),
    );
  }

  void SignOut(BuildContext context) async {
    if (UserCredential != null) {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.signOut();
      await _auth.authStateChanges();
      locator<NavigationUtil>().pushReplacement(context, logout);
    }
  }
}
