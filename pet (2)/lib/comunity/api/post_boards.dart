import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pet/common/component/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> PostBoards(List<MultipartFile> file, String title, String content, bool ispet) async {
  var prefs = await SharedPreferences.getInstance();
  String token =  prefs.getString('accessToken')??"";
  var dio = Dio();

  print("안녕");
  for(int i=0;i<file.length;i++){
    print(file[i].filename);
  }
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

  http.Response respon = await http.post(
    Uri.parse('$url/boards'),
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

  return response.statusCode;
}
