import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoproject/Model/blog_model.dart';
import 'package:demoproject/Model/user_model.dart';
import 'package:demoproject/Res/res_users.dart';
import 'package:demoproject/utils/color_constants.dart';
import 'package:demoproject/home/ui/blog_list_widget.dart';
import 'package:demoproject/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home( {Key key, this.user}) : super(key: key);
  final User user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController commentController = TextEditingController();

  CollectionReference blog = FirebaseFirestore.instance.collection('blog');
  var documentId = FirebaseAuth.instance.currentUser.uid;

  CollectionReference sports = FirebaseFirestore.instance.collection('sports');

  bool isSwitched = false;

  final Res resUsers = Res();

  List<BlogModel> blogModel;
// List  list=[];
//
//   BlogModel model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setBlogData();
    // tojson();
  }


  //
  //  tojson()async{
  // final jsonadata=   await model.toJson();
  // print("////$jsonadata");
  //
  // list.add(jsonadata);
  // print(list);
  //  }




  Future<void> setBlogData() async {
    blogModel = await resUsers.getAllBlogData();
    setState(() {});
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstants.red.shade300,
          primary: true,
          appBar: AppBar(
            title: Text("My Blog"),
            backgroundColor: ColorConstants.red,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Text('Sports'),
              ),
              Switch(
                onChanged: toggleSwitch,
                value: isSwitched,
              )
            ],
          ),
          drawer: CustomDrawer(widget.user),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: isSwitched ? sports.snapshots() : blog.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.hasData) {
                          var data = snapshot.data.docs.length;
                          return Expanded(
                            child: ListView.builder(
                              itemCount: blogModel?.length??0,
                              itemBuilder: (context, index) {
                                final docId = snapshot.data.docs[index].id;
                                return Column(
                                  children: [
                                    BlogList(
                                      snapshot: snapshot.data.docs[index],
                                      docId: docId,
                                      isSwitched: isSwitched,

                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }))
            ],
          )),
    );
  }
}
