import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instance;

Future getUserProfilePicture(String uid) async {
  var avatar = await storage.ref().child('$uid/avatar').getDownloadURL();
  print(avatar);
  return avatar;
}
