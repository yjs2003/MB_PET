import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:pet/comunity/api/model/boardModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

//글 목록 가져오기
Future<List<boardModel>> GetBoards() async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  http.Response response = await http.get(
    Uri.parse('$url/boards?page=0&size=30'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  print(body);
  List<dynamic> lists = body['data']['boards'];
  List<boardModel> content =lists.map((dynamic e) =>
      boardModel.fromJson(e)).toList();
  return content;
}
