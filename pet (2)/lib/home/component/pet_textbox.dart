import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PetTextBox extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const PetTextBox(
      {required this.controller, required this.hintText, super.key});

  @override
  State<PetTextBox> createState() => _PetTextBoxState();
}

class _PetTextBoxState extends State<PetTextBox> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        width: 200.w, // 더 길게 설정
        height: 25.h, // 더 얇게 설정
        child: TextField(
          keyboardType: widget.hintText=="Age"? TextInputType.number:TextInputType.text,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w900, // 힌트 텍스트를 굵게
              fontSize: 15.sp, // 텍스트 크기 설정
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w)),
          style: TextStyle(
            fontWeight: FontWeight.w900, // 입력 텍스트를 굵게
            fontSize: 15.sp, // 텍스트 크기 설정
          ),
          controller: widget.controller,
        ),
      ),
      SizedBox(height:18.h)
    ]);
  }
}
