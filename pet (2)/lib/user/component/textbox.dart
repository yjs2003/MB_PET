import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextBox extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;

  const TextBox({
    required this.title,
    required this.controller,
    required this.hintText,
    super.key});

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.title),
          Container(
              width: 200.w,
              child: TextField(
                obscureText: widget.title=="Password"?true:false,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: OutlineInputBorder()
                ),
                controller: widget.controller,
              )),
          SizedBox(height: 10.h)
        ]);
  }
}
