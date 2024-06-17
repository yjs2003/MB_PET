import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:shared_preferences/shared_preferences.dart';


//펫 수정
Future<dynamic> PutPetsType(String id,String name, int age, String spcies, String gender) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  http.Response response = await http.put(
    Uri.parse('$url/pets/$id'),
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
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  return response.statusCode;
}