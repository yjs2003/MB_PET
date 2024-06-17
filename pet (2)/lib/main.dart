import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/common/basic.dart';
import 'package:pet/common/permission.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/home/home_screen.dart';
import 'package:pet/home/profile_screen.dart';
import 'package:pet/user/login_screen.dart';
import 'package:pet/user/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/component/url.dart';

Widget screen=LoginScreen();

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  nickname =  prefs.getString('nickname')??"";
  if( prefs.getString('accessToken') !=null) screen= Basic();
  runApp(ProviderScope(child:ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MyApp();
      })));
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key});

  @override
  Widget build(BuildContext context) {

    startListening();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:screen,//LoginScreen()으로 변경
    );
  }
}
