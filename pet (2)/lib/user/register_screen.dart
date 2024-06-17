import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/user/api/post_register.dart';
import 'package:pet/user/component/textbox.dart';
import 'package:pet/user/login_screen.dart';

class RigisterScreen extends StatefulWidget {
  const RigisterScreen({super.key});

  @override
  State<RigisterScreen> createState() => _RigisterScreenState();
}

class _RigisterScreenState extends State<RigisterScreen> {
  TextEditingController name= TextEditingController();
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();
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
      body: SingleChildScrollView(child:  Padding(
        padding: EdgeInsets.all(30),
        child:
      Center(child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
          child:Text("Create account",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w800),),
          ),
          SizedBox(height: 40.h),
          TextBox(title: "Username",hintText: "Your username", controller: name),
          SizedBox(height: 20.h),
          TextBox(title: "Email",hintText: "Your email", controller: email),
          SizedBox(height: 20.h),
          TextBox(title: "Password",hintText: "Your password", controller: password),
          right==false ?
          Align(alignment: Alignment.centerLeft,child:
          Padding(padding: EdgeInsets.only(bottom: 10),child: Text("The format is not valid.",style: TextStyle(color: Colors.red),)
          ))   :Container(),
          SizedBox(height: 30.h),
          ElevatedButton(
            onPressed:() async {
            int loginCheck =await PostRegister(name.text ,email.text, password.text);
            if(loginCheck==201){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen()),
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
              "sign up",
              style: TextStyle(color: Colors.white), // 텍스트 색상
            ),
          ),
          SizedBox(height: 60.h,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false,
                    ),
                    child: Text("Log in",style: TextStyle(fontWeight: FontWeight.w800),)
                )
              ]),

        ],
      ),
      )
      )));
  }
}
