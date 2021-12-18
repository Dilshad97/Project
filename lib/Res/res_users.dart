import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoproject/Model/blog_model.dart';
import 'package:demoproject/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Res {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Users> getAllUsersData() async {
    CollectionReference _reference =
        FirebaseFirestore.instance.collection('user');
    try {
      var userRes = await _reference.doc(_auth.currentUser.uid).get();
      print(userRes);
      return Users.fromJson(userRes.data());
    } catch (e) {
      print('///error$e');
    }
  }

  Future<List<BlogModel>> getAllBlogData() async {
    CollectionReference reference = FirebaseFirestore.instance.collection('blog');
    try {
      var resBlog = await reference.get();
      List<BlogModel> list = [];
      resBlog.docs.forEach((element) {
        element.data();
        list.add(BlogModel(
            description: element.data()['Description'],
            author: element.data()['Author'],
            catogory: element.data()['catogory'],
            tittle: element.data()['Tittle'],
            like: element.data()['like']));
      });
      return list;
    } catch (e){
      print('///$e');

    }
  }


  // Future<Users> getUsrTojson(){
  //
  //   CollectionReference _reference =
  //   FirebaseFirestore.instance.collection('user');
  //   try{
  //     var tojson=_reference.doc(_auth.currentUser.uid).get();
  //     return JsonEncoder(Map<Users>)
  //
  //   }
  //
  // }



}
