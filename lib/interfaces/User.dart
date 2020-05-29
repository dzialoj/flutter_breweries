import 'package:beer/services/http_service.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final DateTime joinDate;
  final String avatarImage;
  final String password;
  final int phoneNumber;

  User(
    this.uid,
    this.username,
    this.password,
    this.email,
    this.joinDate,
    this.avatarImage,
    this.phoneNumber
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(json['uid'], json['displayName'], null, json['email'],
        json['createdAt'], json['photoUrl'], json['phoneNumber']);
  }

  //endpoints for users
  //get user by id
  //update user profile
}
