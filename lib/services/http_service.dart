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