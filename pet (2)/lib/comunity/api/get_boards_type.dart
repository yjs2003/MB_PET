import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:pet/comunity/api/model/detailModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


//특정 게시글 가져오기
Future<detailModel> GetBoardsType(String id) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  http.Response response = await http.get(
    Uri.parse('$url/boards/$id'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  print(response.statusCode);
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  dynamic lists = body['data'];
  print(lists);
  detailModel content = detailModel.fromJson(lists); // 단일 객체로 변환
  return content;
}