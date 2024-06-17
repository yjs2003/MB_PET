import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/component/url.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final Color color;
  final int index;
  final String text;
  final double height;
  final VoidCallback function;
  final String category;

  CategoryCard({
    required this.imageUrl,
    required this.color,
    required this.index,
    required this.text,
    required this.height,
    required this.function,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return
      Card(
        color: color,
      child: InkWell(
        // onTap 콜백 수정
          onTap: () async {
            categorys = category;
            function();
          },
          child:Container(
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.contain,
            ),
          ),
          child:Padding(
            padding: EdgeInsets.all(15),
            child:Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 19.sp, // 텍스트 크기 조정
                  ),
                )),
          )
          )),
      );
  }
}