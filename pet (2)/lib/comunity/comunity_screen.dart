import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/comunity/component/post_card.dart';
import 'package:pet/comunity/component/post_textbox.dart';
import 'package:pet/comunity/component/write_button.dart';
import 'package:pet/comunity/post_detail_screen.dart';
import 'package:pet/comunity/post_list_screen.dart';
import 'package:pet/comunity/post_write_screen.dart';

class ComunityScreen extends StatefulWidget {
  const ComunityScreen({super.key});

  @override
  State<ComunityScreen> createState() => _ComunityScreenState();
}

class _ComunityScreenState extends State<ComunityScreen> {
  bool detail = false, write = false;
  @override
  Widget build(BuildContext context) {
    if(detail)
      return PostDetailScreen(setWrite: setWrite,seDetail: setDetail,);
    else if(write)
      return PostWriteScreen(setScreen:setWrite);
    else
      return PostListScreen(setDetail: setDetail,setWrite: setWrite,);
  }

  void setDetail(){
    setState(() {
      detail=!detail;
    });
  }
  void setWrite(){
    setState(() {
      write= !write;
    });
  }
}
