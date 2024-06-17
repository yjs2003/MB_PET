import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/common/basic.dart';
import 'package:pet/user/api/post_login.dart';
import 'package:pet/user/component/textbox.dart';
import 'package:pet/user/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool right = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerRight,
            child: Image.asset('asset/image/petIcon.png',width: 50.w,)
          ),
        ),
        body: SingleChildScrollView(child:
        Padding(
            padding: EdgeInsets.all(30),
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  TextBox(
                      title: "Email",
                      hintText: "Your email",
                      controller: email),
                  SizedBox(height: 30.h),
                  TextBox(
                      title: "Password",
                      hintText: "Your password",
                      controller: password),
                  right==false ?
                      Align(alignment: Alignment.centerLeft,child:
                  Padding(padding: EdgeInsets.only(bottom: 10),child: Text("Invalid information entered",style: TextStyle(color: Colors.red),)
                      ) )  :Container(),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () async {
                      int loginCheck =await PostLogin(email.text, password.text);
                      if(loginCheck==200){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Basic()),
                              (Route<dynamic> route) => false,);
                      }
                      else{
                        setState(() {
                          right = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // 배경 색상
                      minimumSize: Size(280.w, 40.h), // 최소 크기 (가로 300, 세로 50)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // 둥근 테두리
                      ),
                    ),
                    child: Text(
                      "Log in",
                      style: TextStyle(color: Colors.white), // 텍스트 색상
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Don't you have an account?"),
                    TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RigisterScreen()),
                              (Route<dynamic> route) => false,
                            ),
                        child: Text(
                          "sign up",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ))
                  ]),
                ],
              ),
    ))));
  }
}
