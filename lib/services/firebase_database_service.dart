import 'package:beer/interfaces/Post.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Future<List<Post>> getPosts() async {
  List<Post> allPosts = [];
  await database
      .reference()
      .child('posts')
      .once()
      .then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> map = snapshot.value;
    map.values.toList().forEach((snapshot) {
      allPosts.add(snapshot);
    });
  });
  return allPosts;
}
