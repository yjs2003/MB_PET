import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostTextbox extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final double? height;

  const PostTextbox({
    required this.controller,
    required this.hintText,
    this.height,
    super.key});

  @override
  State<PostTextbox> createState() => _PostTextboxState();
}

class _PostTextboxState extends State<PostTextbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 200.w,
            height: widget.height ==null ?  double.maxFinite :widget.height,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              controller: widget.controller,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:widget.hintText,
               ),
            ),
          ),
          SizedBox(height: 20.h)
        ]);
  }
}
