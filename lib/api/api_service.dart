import 'package:cies_web_socket/global/environment.dart';
import 'package:cies_web_socket/global/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> postApi(String url, dynamic data, {dynamic headers}) async {
  final http.Response response = await http.post(
    Uri.parse('${Environment.url}/$url'),
    headers: headers ?? {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  } else {
    if (response.statusCode >= 500) {
      return {"status": false, "message": "Server Error"};
    }
    return {"status": false, "message": response.body};
  }
}

Future<dynamic> putApi(String url, String id, dynamic data,
    {dynamic headers}) async {
  final http.Response response = await http.put(
    Uri.parse('${Environment.url}/$url/$id'),
    headers: headers ?? {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  } else {
    if (response.statusCode >= 500) {
      return {"status": false, "message": "Server Error"};
    }
    return {"status": false, "message": response.body};
  }
}

Future<dynamic> getApi(String url, {dynamic headers}) async {
  final http.Response response = await http.get(
    Uri.parse('${Environment.url}/$url'),
    headers: headers ?? {'Content-Type': 'application/json'},
  );
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  } else {
    if (response.statusCode >= 500) {
      return {"status": false, "message": "Server Error"};
    }
    return {"status": false, "message": response.body};
  }
}

Future<dynamic> loginApi(String username, String password) async {
  dynamic data = {"email": username, "password": password};
  var resp = await postApi('api/auth/login', data);
  if (resp["status"] != null && resp["status"] == false) {
    return {
      "status": false,
    };
  }
  // await LocalStorage.sharedPreferences.setString('refresh', resp["refresh"]);
  // await LocalStorage.sharedPreferences.setBool('totp', resp["totp"]);
  await LocalStorage.sharedPreferences.setString('access', resp["access"]);
  return resp;
}

Future<String> getCode2Fa() async {
  final access = LocalStorage.sharedPreferences.getString('access');
  var resp = await postApi(
    'api/auth/totp-create',
    null,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access'
    },
  );
  if (resp["status"] == true) {
    return resp["item"];
  }
  return "";
}

Future<dynamic> verify2Fa(String code) async {
  final access = LocalStorage.sharedPreferences.getString('access');
  dynamic data = {"code": code};
  var resp = await postApi(
    'api/auth/totp-login',
    data,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access'
    },
  );
  return resp;
}
