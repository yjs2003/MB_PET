import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PetContainer extends StatelessWidget {
  final String petcon;
  final String? content;
  final Color color;
  final double? width;

  const PetContainer({
    required this.petcon,
    required this.color,
    this.content,
    this.width,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(right: 10),
      child:
      Column(children: [
      Container(
          width: width!=null?width: 60.w,
          height: width!=null?width: 60.w,
          decoration: BoxDecoration(
            color:color, // 연한 노란색 배경
            borderRadius: BorderRadius.circular(10.0), // 둥근 테두리
          ),
          child: Center(
            child: Text(
              petcon, // 이모지
              style: TextStyle(fontSize: 35.r),
            ),
    )),
      content!=null?
      Padding(padding: EdgeInsets.symmetric(vertical: 5),
      child:
      Text(content!,style: TextStyle(fontWeight: FontWeight.w700),)
      ):Container()
    ]
    ));
  }
}
