import 'package:http/http.dart' as http;

// So this is a pain in the ass, need to use local ip to connect to locahost for now...

Future<dynamic> submitLogin(username, password) async {
  try {
    var uri = Uri.http('192.168.1.6:3000', '/api/login');
    Map<String, String> headers = {"Content-type": "application/json"};
    String data = '{"username": "$username", "password": "$password"}';
    return await http.post(uri, headers: headers, body: data);
  } catch (error) {
    print(error);
  }
}

Future submitLogout() async {
  try {
    var uri = Uri.http('192.168.1.6:3000', '/api/logout');
    var response = await http.get(uri);
    print(response.body);
    return response;
  } catch (error) {
    print(error);
  }
}

Future createAccount(userData) async {
  try {
    var uri = Uri.http('192.168.1.6:3000', '/api/createuser');
    Map<String, String> headers = {"Content-Type": "application/json"};
    String data =
        '{"username": "${userData["username"]}","avatar": "${userData["avatar"]}", email": "${userData["email"]}", "password": "${userData["password"]}"}';
    return await http.post(uri, headers: headers, body: data);
  } catch (error) {
    print(error);
  }
}
// Future fetchLocalBreweries(city,state) async {
//   try {
//     var uri = Uri.http('192.168.1.6:3000', '/api/breweries');
//     Map<String,String>  headers = {"Content-Type": "application/json"};
//     String data = '{"city": "$city", "state": "$state"}';
//     return await http.get(uri, headers: headers, body: data);
//   } catch {

//   }
// }
