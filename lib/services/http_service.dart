import 'package:http/http.dart' as http;

// So this is a pain in the ass, need to use local ip to connect to locahost for now...
//192.168.1.83
//192.160.1.6

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

// Future getCurrentUserFromDb() async {
//   try {
//     var uri = Uri.http('192.168.1.83:3000', '/api/currentUser');
//     return await http.get(uri);
//   } catch (e) {
//     print(e);
//   }
// }

// Future fetchLocalBreweries(city,state) async {
//   try {
//     var uri = Uri.http('192.168.1.83:3000', '/api/breweries');
//     Map<String,String>  headers = {"Content-Type": "application/json"};
//     String data = '{"city": "$city", "state": "$state"}';
//     return await http.get(uri, headers: headers, body: data);
//   } catch {

//   }
// }
