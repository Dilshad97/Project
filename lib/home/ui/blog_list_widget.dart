import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogList extends StatefulWidget {
  const BlogList({Key key, this.snapshot, this.docId}) : super(key: key);
  final QueryDocumentSnapshot snapshot;
  final String docId;

  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference userdataref =
      FirebaseFirestore.instance.collection('user');

  Map<String, dynamic> userData;

  @override
  initState() {
    super.initState();
    setData();
  }

  void setData() async {
    await userdataref.doc(_auth.currentUser.uid).get().then((value) {
      userData = value.data();
    });
  }

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var likecount = widget.snapshot['like'];
    var blogTittle = widget.snapshot['Tittle'];
    var docId = widget.snapshot.id;
    CollectionReference comment = FirebaseFirestore.instance
        .collection('blog')
        .doc(docId)
        .collection('comments');

    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.snapshot["Tittle"],
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '@ #${widget.snapshot['Author']}',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Text("${widget.snapshot['Description']}"),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: likecount == 1
                            ? Icon(
                                Icons.favorite,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                        onPressed: () {
                          if (likecount == 1) {
                            like(docId);
                            likeBlogUpdate(blogTittle);
                          } else {
                            dislike(docId);
                            dislikeBlogUpdate(blogTittle);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.grey.shade100,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: comment.orderBy('time and data ').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.hasData) {
                          var myList = snapshot.data.docs.length;
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("Tap to view comments"),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: myList,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(widget
                                                      .snapshot["Author"]),
                                                  subtitle: Text(snapshot.data
                                                      .docs[index]['comments']),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return Divider(
                                                  height: 2,
                                                  thickness: 2,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 2,
                                thickness: 2,
                              );
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: OutlineInputBorder(),
                      hintText: 'Write Your Fist Comment',
                      suffixIcon: IconButton(
                        onPressed: () {
                          onCommentSubmit(docId);
                        },
                        icon: Icon(Icons.send),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  like(String docId) async {
    CollectionReference blog = FirebaseFirestore.instance.collection('blog');
    await blog
        .doc(docId)
        .update(
          {
            'like': 2,
          },
        )
        .then((value) => print("///Comment saved "))
        .catchError((error) {
          print("/// error in saving $error");
        });
  }

  dislike(String docId) async {
    CollectionReference blog = FirebaseFirestore.instance.collection('blog');
    await blog
        .doc(docId)
        .update(
          {
            'like': 1,
          },
        )
        .then((value) => print("///Comment saved "))
        .catchError((error) {
          print("/// error in saving $error");
        });
  }

  likeBlogUpdate(String blogTittle) async {
    CollectionReference likeBlogUpdate =
        FirebaseFirestore.instance.collection('user');

    FirebaseAuth _auth = FirebaseAuth.instance;
    userData = <String, dynamic>{
      ...userData,
      "likedBlog": [...userData['likedBlog'], blogTittle],
    };

    await likeBlogUpdate
        .doc(_auth.currentUser.uid)
        .set(userData)
        .then((value) => print("/// user save to firebase"))
        .catchError((error) => print("///user added failed to firebase$error"));
  }

  dislikeBlogUpdate(String blogTittle) async {
    CollectionReference likeBlogUpdate =
        FirebaseFirestore.instance.collection('user');

    FirebaseAuth _auth = FirebaseAuth.instance;
    var list = userData['likedBlog'] as List;
    list.removeWhere((element) => element == blogTittle);
    Map data = <String, dynamic>{
      ...userData,
      "likedBlog": list,
    };

    await likeBlogUpdate
        .doc(_auth.currentUser.uid)
        .set(data)
        .then((value) => print("/// user save to firebase"))
        .catchError((error) => print("///user added failed to firebase$error"));
  }

  onCommentSubmit(String docId) async {
    CollectionReference reference = FirebaseFirestore.instance
        .collection('blog')
        .doc(docId)
        .collection('comments');
    await reference.doc().set(
        {'comments': commentController.text, 'time and data ': DateTime.now()});
    commentController.clear();
  }
}
