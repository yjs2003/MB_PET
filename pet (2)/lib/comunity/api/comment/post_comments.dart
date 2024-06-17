import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:shared_preferences/shared_preferences.dart';


//댓글 생성하기
Future<dynamic> PostComments(String id, String content)async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  http.Response response = await http.post(
    Uri.parse('$url/boards/$id/comments'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body:jsonEncode({
      "content":content
    }),
  );
  print(response.statusCode);
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));

  return response.statusCode;
}