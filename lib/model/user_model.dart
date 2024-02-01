import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String ? email;
  String ? password;
  String ? userId;
  String ? username;

  UserModel({
    this.email,
    this.password,
    this.userId,
    this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    password: json["password"],
    userId: json["userId"],
    username: json["username"],
  );


  factory UserModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => UserModel(
    email: json["email"],
    password: json["password"],
    userId: json["userId"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "userId": userId,
    "username":username,
  };
}
