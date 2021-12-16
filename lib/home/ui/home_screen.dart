import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoproject/utils/color_constants.dart';
import 'package:demoproject/home/ui/blog_list_widget.dart';
import 'package:demoproject/widgets/drawer.dart';

import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController commentController = TextEditingController();

  CollectionReference blog = FirebaseFirestore.instance.collection('blog');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstants.red.shade300,
          primary: true,
          appBar: AppBar(
            title: Text("My Blog"),
            backgroundColor: ColorConstants.red,
          ),
          drawer: CustomDrawer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: blog.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.hasData) {
                          var data = snapshot.data.docs.length;
                          return Expanded(
                            child: ListView.builder(
                              itemCount: data,
                              itemBuilder: (context, index) {
                                final docId = snapshot.data.docs[index].id;
                                return BlogList(
                                  snapshot: snapshot.data.docs[index],
                                  docId: docId,
                                );
                              },
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      }))
            ],
          )),
    );
  }
}
