import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:pet/home/api/pet_detail_model.dart';
import 'package:pet/home/api/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


//특정펙 상세조회
Future<petDetailModel> GetPetsType(String id) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  http.Response response = await http.get(
    Uri.parse('$url/pets/$id'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  dynamic data = body['data'];
  petDetailModel content = petDetailModel.fromJson(data); // 단일 객체로 변환
  return content;
  //return content;
}