import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/common/component/url.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String id;
  final String content;
  final int heartCount;
  final int commentCount;
  final ImageProvider? image;
  final VoidCallback setDetail;
  final bool isPet;

  const PostCard({
    required this.title,
    required this.id,
    required this.content,
    required this.heartCount,
    required this.commentCount,
    this.image,
    required this.setDetail,
    required this.isPet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      child:
      Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // 약간 둥근 모서리
      ),
      child: InkWell(
    onTap: () async {
      detailId = id;
      print(id);
      setDetail();
    },
    child:Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      content,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 14.0.h),
              Row(
                children: [
                 Icon(Icons.favorite_border),
                  SizedBox(width:2.w),
                  Text('$heartCount'),
                  SizedBox(width:10.w),
                  Icon(Icons.chat_bubble_outline),
                  SizedBox(width:2.w),
                  Text('$commentCount'),
                ],
              ),
              ],
              ),
            ),
            if(isPet)
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child:
              Container(
                height: 40.w,
                child: Image.asset('asset/image/pethelp.png')
              ))
            ),
            if (image != null) // 이미지가 있는 경우에만 표시
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Row(
                  children: [
                    SizedBox(width: 10.w),
                    Image(
                      image: image!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              ),
          ],
        ),
      ),
      )));
  }
}
