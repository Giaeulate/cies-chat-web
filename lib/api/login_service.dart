import 'dart:convert';
import 'package:cies_web_socket/api/api_service.dart';
import 'package:cies_web_socket/global/environment.dart';
import 'package:cies_web_socket/global/local_storage.dart';
import 'package:http/http.dart' as http;

final String _url = Environment.url;
const String _endPoint = 'curso/custom_login/';

Future<bool> loginService(String username, String password) async {
  try {
    var resp = await postApi(_endPoint, {
      'username': username,
      'password': password,
    });
    if (resp["superusuario"].toString() == "true") {
      await LocalStorage.sharedPreferences
          .setString('refresh', resp["token"]["refresh"]);
      await LocalStorage.sharedPreferences
          .setString('access', resp["token"]["access"]);
    }
    return resp["superusuario"].toString() == "true";
  } catch (e) {
    return false;
  }
}

Future<dynamic> verifyAfiliacionService(
    String document, String birthdate) async {
  final http.Response response = await http.post(
    Uri.parse('$_url/curso/custom_verify_user/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: json.encode({'document': document, 'birthdate': birthdate}),
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  return {"status": false};
}
