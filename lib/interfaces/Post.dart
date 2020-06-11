import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  final String imageUrl;
  final Object user;
  final String latitude;
  final String longitude;
  final String description;
  final String createdOn;

  Post(this.id, this.title, this.imageUrl, this.user, this.latitude,
      this.longitude, this.description, this.createdOn);

  @override
  toString() => 'Post: $title';

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      json['id'],
      json['title'],
      json['imageUrl'],
      json['user'],
      json['latitude'],
      json['longitude'],
      json['description'],
      json['createdOn'],
    );
  }

  static Future<List<Post>> get(String lat, String long) async {
    //TODO: get posts based on user location
    return null;
  }
}
