import 'package:beer/services/firebase_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

Future<String> signInEmailPassword(String email, String password) async {
  try {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser currentUser = result.user;
    if (currentUser.isEmailVerified) {
      return currentUser.uid;
    } else {
      return 'Please verify your email address.';
    }
  } catch (e) {
    return null;
  }
}

Future createUserEmailPassword(data) async {
  FirebaseUser user;
  UserUpdateInfo info = new UserUpdateInfo();
  info.displayName = data['username'];
  try {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: data.email, password: data.password)
        .then((value) => user = value.user);
    var storageRef = _firebaseStorage.ref().child('${user.uid}/avatar');
    storageRef.putFile(data['avatar']);
    info.photoUrl = await storageRef.getDownloadURL();
    await user.updateProfile(info);
    await user.reload();
    user.sendEmailVerification();
  } catch (e) {
    print(e);
    return null;
  }
}

Future getCurrentUserFirebaseUser() async {
  try {
    var user = await _firebaseAuth.currentUser();
    return user;
  } catch (e) {
    return null;
  }
}

Future signOut() async {
  try {
    await _firebaseAuth.signOut();
  } catch (e) {
    return null;
  }
}
