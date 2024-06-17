import 'package:flutter/material.dart';
import 'package:pet/common/component/url.dart';

class WriteButton extends StatelessWidget {
  final VoidCallback setWrite;

  const WriteButton({
    required this.setWrite,
    super.key});

  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(
      onPressed: (){
        detailId="";
        setWrite();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white), // 배경색을 흰색으로 설정
        padding: MaterialStateProperty.all(EdgeInsets.zero), // 패딩 제거
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: Colors.black), // 검은 테두리
            borderRadius: BorderRadius.circular(16.0), // 테두리를 조금 둥글게 만듦
          ),
          ),
        ),
      child:Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min, // 최소한의 공간만 사용하도록 설정
        children: [
          Icon(Icons.edit), // Edit 아이콘
          SizedBox(width: 8.0), // 아이콘과 텍스트 사이 공백
          Text('글쓰기',style: TextStyle(fontWeight: FontWeight.w600),), // 글쓰기 텍스트
        ],
      )),
    );
  }
}
