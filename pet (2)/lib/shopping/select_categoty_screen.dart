import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'component/category_card.dart';

class SelectCategoryscreen extends StatefulWidget {
  final VoidCallback function;

  const SelectCategoryscreen({required this.function, super.key});

  @override
  State<SelectCategoryscreen> createState() => _SelectCategoryscreenState();
}

class _SelectCategoryscreenState extends State<SelectCategoryscreen> {
  @override
  Widget build(BuildContext context) {
    List<String> title = [
      'BEST ITEM',
      'BEST ITEM',
      'Dog Food',
      'Cat Food',
      'Dog Treats',
      'Cat Treats',
      'Dog Products',
      'Cat Products'
    ];

    List<String> category = [
      'DOG_BEST_ITEMS',
      'CAT_BEST_ITEMS',
      'DOG_FOOD',
      'CAT_FOOD',
      'DOG_SNACKS',
      'CAT_SNACKS',
      'DOG_SUPPLIES',
      'CAT_SUPPLIES',
    ];
    List<Color> color = [
      Color(0xE653B175),
      Color(0xE6F8A44C),
      Color(0xE6F7A593),
      Color(0xE6D3B0E0),
      Color(0xE6FDE598),
      Color(0xE6B7DFF5),
      Color(0xE6FFC5BF),
      Color(0xE6CCE2CB)
    ];
    List<String> image = [
      "asset/image/best.png",
      "asset/image/best.png",
      "asset/image/dogfood.png",
      "asset/image/catfood.png",
      "asset/image/dogtreat.png",
      "asset/image/cattreat.png",
      "asset/image/dogprod.png",
      "asset/image/catprod.png",
    ];
    return Scaffold(
        appBar: AppBar(
            title: Align(
                alignment: Alignment.centerRight,
                child: Image.asset('asset/image/petIcon.png',width: 50.w,)
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              // 상단의 긴 컨테이너
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                      color: Color(0xFFABDEE6),
                      child: Container(
                          //height: height,
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage("asset/image/dog.png"),
                                    width: 30.w,
                                  ),
                                  Text(
                                    'Dog Zone',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp, // 텍스트 크기 조정
                                    ),
                                  ),
                                  Image(
                                      image: AssetImage("asset/image/dog.png"),
                                      width: 30.w)
                                ],
                              )))),
                  Card(
                      color: Color(0xFFCBA4CB),
                      child: Container(
                          //height: height,
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Image(
                                      image: AssetImage("asset/image/cat.png"),
                                      width: 30.w),
                                  Text(
                                    'Cat Zone',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp, // 텍스트 크기 조정
                                    ),
                                  ),
                                  Image(
                                      image: AssetImage("asset/image/cat.png"),
                                      width: 30.w)
                                ],
                              ))))
                ],
              ),
              SizedBox(height: 16.h),
              // 2*3 행렬로 나열된 컨테이너들
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: 8,
                // 8개의 아이템
                itemBuilder: (BuildContext context, int index) {
                  return CategoryCard(
                    category: category[index],
                    imageUrl: image[index],
                    color: color[index],
                    index: index + 1,
                    text: title[index],
                    height: 240.h,
                    function: widget.function,
                  );
                },
              ),
            ],
          ),
        ));
  }
}
