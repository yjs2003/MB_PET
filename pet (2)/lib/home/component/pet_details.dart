import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/common/component/url.dart';
import 'package:pet/home/api/delete_pets_type.dart';
import 'package:pet/home/component/icon_button.dart';
import 'package:pet/home/component/myprofile.dart';
import 'package:pet/home/component/remove_button.dart';
import '../../common/basic.dart';
import '../../common/provider.dart';
import '../homemain_screen.dart';

final removeProvider = StateProvider<bool>((ref) => true); // 초기값은 true로 설정
class PetDetail extends ConsumerWidget {
  final VoidCallback setScreen;

  const PetDetail({
    required this.setScreen,
    Key? key,
  }) : super(key: key);

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      var isdetail = ref.watch(homepetProvider(petId));

      return isdetail.when(
        data: (detail) {
          print("상세$petId");
          return  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 45.w),
                  Text(
                    "Pet Details",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                  ),
                  IconButtons(
                    icons: Icon(Icons.more_vert),
                    onPressed: () async {
                      isRemove = !isRemove;
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => Basic(),
                          transitionDuration: Duration(seconds: 0), // 애니메이션 없음
                        ),
                            (route) => false,
                      );
                    },
                  )
                ],
              ),
              SizedBox(height: 10.h),
              RemoveButton(setScreen: setScreen,),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyProfile(
                    color: Color(0xFFecfbc7),
                    title: detail.name,
                    content: detail.species,
                    procon: detail.species=="DOG" ? '🐶' : '🐱',
                  ),
                  IconButtons(icons: Icon(Icons.mode_edit_outline_outlined),
                      onPressed: () async {
                        //ref.refresh(homeProvider);
                        setScreen();
                      })
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFfbf3ec),// 연한 노란색 배경
                        borderRadius: BorderRadius.circular(8.0), // 둥근 테두리
                      ),
                      width: 150.w,
                      height: 70.h,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Gender", style: TextStyle(
                                fontSize: 10.sp, color: Colors.black),),
                            Text(detail.gender, style: TextStyle(fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w800))
                          ],
                        ),
                      )),
                  Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFf0f3fe),// 연한 노란색 배경
                        borderRadius: BorderRadius.circular(8.0), // 둥근 테두리
                      ),
                      width: 150.w,
                      height: 70.h,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Age", style: TextStyle(
                                fontSize: 10.sp, color: Colors.black)),
                            Text(detail.age.toString(), style: TextStyle(fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w800))
                          ],
                        ),
                      ))
                ],
              )
            ],
          );
        },
          loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) {
      print('Error in UI: $error'); // 에러 메시지 출력
      return Container();
      },
      );
    }
  }


