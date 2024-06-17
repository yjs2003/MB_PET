import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

//글 삭제하기
Future<dynamic> DeleteBoardsType(String id) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  http.Response response = await http.delete(
    Uri.parse('$url/boards/$id'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  print(response.statusCode);
  return response.statusCode;
}