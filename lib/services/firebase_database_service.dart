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
      Post newPost = new Post(
        snapshot['title'],
        snapshot['uid'],
        snapshot['username'],
        snapshot['profileImageUrl'],
        snapshot['latitude'],
        snapshot['longitude'],
        snapshot['description'],
        DateTime.parse(snapshot['createdOn']),
      );
      allPosts.add(newPost);
    });
  });
  return allPosts;
}

Future<void> createPost(post) async {
  try {
    var postRef = database.reference().child('posts').push();
    await postRef.set({
      'title': post.title,
      'userId': post.uid,
      'latitude': post.latitude,
      'longitude': post.longitude,
      'description': post.description,
      'createdOn': post.createdOn.toString(),
      'username': post.username,
      'profileImageUrl': post.profileImageUrl,
    });
  } catch (e) {
    print(e);
  }
}
