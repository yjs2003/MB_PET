import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:pet/home/api/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


//펫 등록
Future<dynamic> PostPets(String name, int age, String spcies, String gender) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  if(spcies=="cat"|| spcies=="CAT"||spcies=="C"){
    spcies="CAT";
  }
  else{
    spcies="DOG";
  }
  http.Response response = await http.post(
    Uri.parse('$url/pets'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body:jsonEncode({
      "name":name,
      "age":age,
      "species":spcies,
      "gender":gender,
    }),
  );
  print(response.statusCode);
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  print(body);
  //return content;
}