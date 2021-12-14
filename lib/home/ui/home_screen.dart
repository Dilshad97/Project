import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoproject/utils/color_constants.dart';
import 'package:demoproject/widgets/drawer.dart';
import 'package:demoproject/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('user');
    String documnetId = FirebaseAuth.instance.currentUser.uid;
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
                child: FutureBuilder<DocumentSnapshot>(
                  future: reference.doc(documnetId).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something Went wrong");
                    }
                    if (snapshot.hasData && !snapshot.data.exists) {
                      return Text("Data Doesnot Exist");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();

                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                child: Card(
                                  margin: EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text("${data['Tittle']}",style: TextStyle(fontSize: 18),),
                                        Text("@ #${ data['firstname'] + ' ' + data['lastname']}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 4,),
                                        Text("${data['Description']}"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        likeButtom(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: commentController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(0),
                                              border: OutlineInputBorder(),
                                              hintText: 'Write Your Fist Comment',
                                              suffixIcon: IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.send),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    )),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 3,
                                ),
                            itemCount: data.length),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }

  Widget likeButtom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LikeButton(
          circleColor:
              CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.thumb_up_alt_sharp,
              color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
              size: 25,
            );
          },
          likeCount: 665,
          countBuilder: (int count, bool isLiked, String text) {
            var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "love",
                style: TextStyle(color: color),
              );
            } else
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            return result;
          },
        ),
        LikeButton(
          circleColor:
              CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.comment,
              color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
              size: 25,
            );
          },
          likeCount: 665,
          countBuilder: (int count, bool isLiked, String text) {
            var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "love",
                style: TextStyle(color: color),
              );
            } else
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            return result;
          },
        ),
        LikeButton(
          circleColor:
              CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.share,
              color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
              size: 25,
            );
          },
          likeCount: 665,
          countBuilder: (int count, bool isLiked, String text) {
            var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "love",
                style: TextStyle(color: color),
              );
            } else
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            return result;
          },
        ),
      ],
    );
  }
}
