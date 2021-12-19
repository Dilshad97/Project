import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoproject/Model/blog_model.dart';
import 'package:demoproject/Model/sports_blog_model.dart';
import 'package:demoproject/Model/user_model.dart';
import 'package:demoproject/Res/res_users.dart';
import 'package:demoproject/utils/color_constants.dart';
import 'package:demoproject/home/ui/blog_list_widget.dart';
import 'package:demoproject/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController commentController = TextEditingController();

  // CollectionReference blog = FirebaseFirestore.instance.collection('blog');
  // var documentId = FirebaseAuth.instance.currentUser.uid;
  //
  // CollectionReference sports = FirebaseFirestore.instance.collection('sports');

  bool isSwitched = false;

  final Res resUsers = Res();
  List<SportsBlogModel> sportsBlog;


  List<BlogModel> blogModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setBlogData();
    setSportsData();
    // tojson();
  }

  /// sports Model data
  Future<void> setSportsData() async {
    sportsBlog = await resUsers.getSportData();
    setState(() {});
  }

  /// Blog model data
  Future<void> setBlogData() async {
    blogModel = await resUsers.getAllBlogData();
    setState(() {});
  }

  ///Filter switch function
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
          drawer: CustomDrawer(),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //     child: StreamBuilder<QuerySnapshot>(
                //         stream: isSwitched ? sports.snapshots() : blog.snapshots(),
                //         builder: (context, snapshot) {
                //           if (snapshot.hasError) {
                //             return Text("Something went wrong");
                //           }
                //           if (snapshot.hasData) {
                //             var data = snapshot.data.docs.length;
                //             return
                Expanded(
                  child: ListView.builder(
                    itemCount: isSwitched?sportsBlog?.length??0:blogModel?.length??0,
                    itemBuilder: (context, index) {
                      // final docId = snapshot.data.docs[index].id;
                      return Column(
                        children: [
                          BlogList(
                            // snapshot: snapshot.data.docs[index],
                            // docId: docId,
                            isSwitched: isSwitched,
                            blogModel: blogModel[index],
                            sportsBlogModel: sportsBlog[index],

                          ),
                        ],
                      );
                    },
                  ),
                )
              ]
            // }
            //             return Center(child: CircularProgressIndicator());
            //           }))
            // ],
          )
      ),
    );
  }
}
