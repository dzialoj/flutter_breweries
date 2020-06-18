import 'dart:convert';

import 'package:http/http.dart' as http;

// So this is a pain in the ass, need to use local ip to connect to locahost for now...
//192.168.1.83
//192.160.1.6
Future<dynamic> submitLogin(username, password) async {
  try {
    var uri = Uri.http('192.168.1.83:3000', '/api/login');
    Map<String, String> headers = {"Content-type": "application/json"};
    String data = '{"username": "$username", "password": "$password"}';
    return await http.post(uri, headers: headers, body: data);
  } catch (error) {
    print(error);
  }
}

//Somethings wrong here
Future submitLogout() async {
  try {
    var uri = Uri.http('192.168.1.83:3000', '/api/logout');
    var response = await http.get(uri);
    print(response.body);
    return response;
  } catch (error) {
    print(error);
  }
}

Future createAccount(userData) async {
  try {
    var uri = Uri.http('192.168.1.83:3000', '/api/createuser');
    Map<String, String> headers = {"Content-Type": "application/json"};
    String data =
        '{"username": "${userData["username"]}","avatar": "${userData["avatar"]}", "email": "${userData["email"]}", "password": "${userData["password"]}"}';
    return await http.post(uri, headers: headers, body: data);
  } catch (error) {
    print(error);
  }
}

Future getCurrentUserFromDb() async {
  try {
    var uri = Uri.http('192.168.1.83:3000', '/api/currentUser');
    return await http.get(uri);
  } catch (e) {
    print(e);
  }
}

Future createNewPost(post) async {
  try {
    var uri = Uri.http('192.168.1.83:3000', '/api/createpost');
    Map<String, String> headers = {"Content-Type": "application/json"};
    return await http.post(uri, headers: headers, body: json.encode(post.toJson()));
  } catch (e) {
    print(e);
  }
}

Future getAllPosts() async {
  try {
    var uri = Uri.http('192.168.1.83:3000', '/api/posts');
    return await http.get(uri);
  } catch(e) {
    print(e);
  }
}

// Future fetchLocalBreweries(city,state) async {
//   try {
//     var uri = Uri.http('192.168.1.83:3000', '/api/breweries');
//     Map<String,String>  headers = {"Content-Type": "application/json"};
//     String data = '{"city": "$city", "state": "$state"}';
//     return await http.get(uri, headers: headers, body: data);
//   } catch {

//   }
// }
