
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//글수정..
Future<dynamic> PutBoardsType(String id,List<MultipartFile> file, String title, String content, bool ispet) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  var dio = Dio();
  FormData formData= FormData.fromMap({
    "files": file.length==0? null:file,
  });
  print(formData);
  var response = await dio.post(
      '$url/images',
      options: Options(
        contentType: 'multipart/form-data',
        headers: {
          'authorization': 'Bearer $token',
        },
      ),
      data:formData
  );
  List<dynamic> lists = response.data['data']['imageUrl'];
  print(lists);

  http.Response respon = await http.put(
    Uri.parse('$url/boards/$id'),
    headers: <String, String>{
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body:jsonEncode({
      "title":title,
      "content":content,
      "isPetHelp":ispet,
      "imageUrl":lists,
    }),
  );

  print(response.data);
  return response.statusCode;
}
