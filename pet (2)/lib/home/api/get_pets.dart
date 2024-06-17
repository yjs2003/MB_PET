import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:pet/home/api/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


//펫 목록 가져오기
Future<List<petModel>> GetPets() async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  print('$url/pets');
  http.Response response = await http.get(
    Uri.parse('$url/pets'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },

  );
  print(response.statusCode);
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  List<dynamic> lists= body['data'];
  List<petModel> content =lists.map((dynamic e) =>
      petModel.fromJson(e)).toList();
  return content;

  //return content;
}