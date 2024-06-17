import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/comment_model.dart';


//댓글 목록 가져오기
Future<List<CommentModel>> GetComments(String id) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  http.Response response = await http.get(
    Uri.parse('$url/boards/$id/comments'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  print(response.statusCode);
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  print("안녕 $body");
  List<dynamic> lists= body['data'];
  List<CommentModel> content =lists.map((dynamic e) =>
      CommentModel.fromJson(e)).toList();
  return content;
}