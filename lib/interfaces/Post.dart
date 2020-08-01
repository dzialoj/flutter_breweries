import 'dart:convert';
import 'package:beer/services/firebase_database_service.dart';
import 'package:http/http.dart' as http;

class Post {
  final String title;
  //final String imageUrl;
  final String uid;
  final String username;
  final String profileImageUrl;
  final double latitude;
  final double longitude;
  final String description;
  final DateTime createdOn;

  Post(
      this.title,
      // this.imageUrl,
      this.uid,
      this.username,
      this.profileImageUrl,
      this.latitude,
      this.longitude,
      this.description,
      this.createdOn);

  // @override
  // toString() =>
  //     'Post: $title \n $description \n $uid \n $username \n $profileImageUrl \n $latitude \n $longitude \n $createdOn';

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      json['title'],
      //json['imageUrl'],
      json['uid'],
      json['username'],
      json['profileImageUrl'],
      json['latitude'],
      json['longitude'],
      json['description'],
      json['createdOn'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "profileImageUrl": profileImageUrl,
        "latitude": latitude,
        "longitude": longitude,
        "title": title,
        "description": description,
        "createdOn": createdOn.toString()
      };

  // static Future<List<Post>> get(String lat, String long) async {
  //   //TODO: get posts based on user location
  //   return null;
  // }

  static Future<List<Post>> get() async {
    List<Post> posts = [];
    try {
      posts = await getPosts();
      return posts;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
