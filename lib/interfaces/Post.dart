import 'dart:convert';
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
    try {
      var uri = Uri.http('192.168.1.83:3000', '/api/posts');
      var response = await http.get(uri);
      final responseJson = json.decode(response.body);
      // final items =
      //     responseJson.map((i) => new Post.fromJson(i)).toList();
      final items = [];
      print(responseJson[0]);
      return items;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
