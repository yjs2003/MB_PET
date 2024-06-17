import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:shared_preferences/shared_preferences.dart';


//글 좋아요
Future<dynamic> PostBoardsLike(String id) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  http.Response response = await http.post(
    Uri.parse('$url/boards/$id/like'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  print(id);
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  print(body);
  return response.statusCode;
}