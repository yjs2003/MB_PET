import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SexButton extends StatefulWidget {
  final String name;
  final bool isTrue;
  final VoidCallback sexCheck;

  const SexButton({
    required this.name,
    required this.isTrue,
    required this.sexCheck,
    super.key});

  @override
  State<SexButton> createState() => _SexButtonState();
}

class _SexButtonState extends State<SexButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90.h,
        color: Color(0xFFfbf3ec),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
         TextButton(onPressed: widget.sexCheck, child:
          Container(
            height: 40.h,
            width: 130.w,
            // 가로 크기
            padding: EdgeInsets.all(8.0),
            // 내부 여백
            decoration: BoxDecoration(
              color: widget.isTrue ? Colors.grey: Colors.grey[100], // 회색 배경
              border: Border.all(color: Colors.grey, width: 1), // 회색 테두리
              borderRadius: BorderRadius.circular(10.0), // 둥근 모서리
            ),
            child: Center(
                child: Text(
              widget.name,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600,color: Colors.black),
            )),
          )
         )
        ]));
  }
}
