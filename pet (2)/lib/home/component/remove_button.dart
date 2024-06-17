import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/common/component/url.dart';
import 'package:pet/common/provider.dart';
import 'package:pet/shopping/shoppingScreen.dart';
import 'package:pet/user/login_screen.dart';
import '../../common/basic.dart';
import '../api/delete_pets_type.dart';
import '../homemain_screen.dart';
//특정펫정보

bool isRemove= false;
class RemoveButton extends ConsumerWidget {
  final VoidCallback setScreen;

  const RemoveButton({
    required this.setScreen,
    super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(isRemove) {
      return ElevatedButton(
        onPressed: () async {
           int del = await DeletePetsType(petId);
          if (del == 200) {
            isRemove = false;
            petId="";
            ref.refresh(homeProvider);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade100, // 배경색 설정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // 둥근 테두리
          ),
          fixedSize: Size(320.w, 40.h), // 고정된 크기
        ),
        child: Text(
          "remove",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
    }
    else{
      return Container();
    }
  }
}
