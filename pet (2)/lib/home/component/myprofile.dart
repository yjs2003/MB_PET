import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfile extends StatelessWidget {
  final Color color;
  final String title;
  final String? content;
  final String procon;

  const MyProfile({
    required this.color,
    required this.title,
    this.content,
    required this.procon,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 65.w,
          height: 65.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0), // 둥근 테두리
          ),
          child: Center(
            child: Text(
              procon, // 이모지
              style: TextStyle(fontSize: 30.r),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16.sp),),
            SizedBox(height: 5.h),
            content!=null ? Text(content!):Container()
          ],
        )
      ],
    );
  }
}
