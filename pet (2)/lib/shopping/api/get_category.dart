import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/categoryModel.dart';

//카테고리 상세보기
Future<List<CategoryModel>> getCategory(String category) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  http.Response response = await http.get(
    Uri.parse('$url/items/$category'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  List<dynamic> lists= body['data'];
  print(body);
  List<CategoryModel> content =lists.map((dynamic e) =>
      CategoryModel.fromJson(e)).toList();
  return content;
}
