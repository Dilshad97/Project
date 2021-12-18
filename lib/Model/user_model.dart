import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String comments;
  String email;
  String firstname;
  String lastname;
  String image;
  List<dynamic> likeBlog;

  Users(
      {this.comments,
        this.email,
        this.firstname,
        this.lastname,
        this.image,
        this.likeBlog});

  Users.fromJson(Map<String, dynamic> json) {
    comments = json['Comments'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    image = json['image'];
    likeBlog = json['likedBlog'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    this.comments = data['Comments'];
    this.email = data['email'];
    this.firstname = data['firstname'];
    this.lastname = data['lastname'];
    this.image = data['image'];
    this.likeBlog = data['likedBlog'];

    return data;
  }

}
