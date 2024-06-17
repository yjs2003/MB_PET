import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:pet/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/basic.dart';


//로그인
Future<dynamic> PostLogin(String email, String password) async {
  http.Response response = await http.post(
    Uri.parse('$url/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body:jsonEncode({
      "email": email,
      "password": password
    }),
  );

  if(response.statusCode==200) {
    dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
    nickname = body['data']['nickname'];

    var prefs =await SharedPreferences.getInstance();
    prefs.setString('accessToken', body['data']['accessToken']);
    prefs.setString('nickname', nickname);
    screen= Basic();
    print(body);
    return response.statusCode;
  }
  else
    return 404;
}