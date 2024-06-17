import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/shopping/link_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String url;
  final String image_url;
  final String price;
  final int index;
  final String category;

  ItemCard({
    required this.name,
    required this.image_url,
    required this.url,
    required this.price,
    required this.index,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 250.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black26, // 테두리 색상
              width: 0.8, // 테두리 두께
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Card(
                elevation: 2,
                child: InkWell(
                    onTap: () async {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => LinkScreen(link: url)));
                      await launch(url,
                          forceWebView: true, forceSafariVC: true);
                    },
                    child: Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image_url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                price == 0 ? "Free" : "${price}₩",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                name,
                style: TextStyle(fontSize: 13.sp, color: Colors.black),
              ),
            ),
          ])),
      SizedBox(
        height: 10.h,
      ),
    ]);
  }
}
