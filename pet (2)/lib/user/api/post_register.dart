import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';


//회원가입하기
Future<dynamic> PostRegister(String nickname, String email, String password) async {
  http.Response response = await http.post(
    Uri.parse('$url/auth/join'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body:jsonEncode({
      "nickname":nickname,
      "email": email,
      "password": password
    }),
  );
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  print(body);
  return response.statusCode;
}