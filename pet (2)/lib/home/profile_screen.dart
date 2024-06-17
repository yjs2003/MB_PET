import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/common/component/url.dart';
import 'package:pet/home/api/get_pets_type.dart';
import 'package:pet/home/api/post_pets.dart';
import 'package:pet/home/api/put_pets_type.dart';
import 'package:pet/home/component/sex_button.dart';

import 'component/pet_container.dart';
import 'component/pet_textbox.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback setScreen;
  final String? petname;
  final String? specie;
  final String? ages;
  final bool? man;

  const ProfileScreen({
    required this.setScreen,
    this.petname,
    this.specie,
    this.ages,
    this.man,
    super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController petName = TextEditingController();
  TextEditingController species = TextEditingController();
  TextEditingController age = TextEditingController();
  bool isMan = true;

  @override
  Widget build(BuildContext context) {
    print(petId);
    print(isMan);
    if(petId!=""){
    return FutureBuilder(future: GetPetsType(petId),   builder: (context, snapshot) {
      if(snapshot.hasData) {
        var data = snapshot.data;
        if(petName.text=="") {
          petName.text = data!.name;
          species.text = data.species;
          age.text = data.age;
          isMan = data.gender == "MALE" ? true : false;
        }

        return Scaffold(
            appBar: AppBar(
                title: Row(
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back_ios_new),
                          onPressed:(){
                              petId="";
                        widget.setScreen();
                      })
                    ]
                )),
            body: SafeArea(
                top: true,
                child: SingleChildScrollView(
                    child:
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Center(
                            child: Column(children: [
                              Text(
                                "Your Pets",
                                style: TextStyle(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              //프로필수정
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  PetContainer(
                                    petcon: data!.species=="DOG"? '🐶':'🐱',
                                    content: "",
                                    color:Color(0xFFecfbc7),
                                    width: 80.w,
                                  ),
                                  Column(
                                    children: [
                                      PetTextBox(controller: petName,
                                          hintText: "Pet Name"),
                                      PetTextBox(controller: species,
                                          hintText: "Species"),
                                      PetTextBox(
                                          controller: age, hintText: "Age"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                        )
                                ],
                              ),
                              //성별
                              Container(
                                height: 90.h,
                                color: Color(0xFFfbf3ec),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    SexButton(name: "male",
                                        isTrue: isMan,
                                        sexCheck: SexCheck),
                                    SexButton(name: "famale",
                                        isTrue: !isMan,
                                        sexCheck: SexCheck),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                width: double.infinity, // 화면 가로가 꽉 차게
                                height: 45.h,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (petId == "") { //생성하기
                                      await PostPets(
                                          petName.text, int.parse(age.text),
                                          species.text,
                                          isMan == true ? "MALE" : "FEMALE");
                                      widget.setScreen();
                                    }
                                    else { //수정하기
                                      await PutPetsType(petId, petName.text,
                                          int.parse(age.text), species.text,
                                          isMan == true ? "MALE" : "FEMALE");
                                      petId="";
                                      widget.setScreen();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF6e88b9),
                                    // 파스텔 파란색
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // 테두리 둥글게
                                    ),
                                  ),
                                  child: Text('complete', style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 18.sp),),
                                ),
                              )
                            ]))))));
      }
      else{
        return Center(child: CircularProgressIndicator());
      }
    });
  }
    else {
      return Scaffold(
          appBar: AppBar(
              title: Row(
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: widget.setScreen)
                  ]
              )),
          body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                  child:
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Center(
                          child: Column(children: [
                            Text(
                              "Your Pets",
                              style: TextStyle(
                                  fontSize: 23.sp, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            //프로필수정
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PetContainer(
                                  petcon: '🐶',
                                  content: "",
                                  color: Color(0xFFecfbc7),
                                  width: 80.w,
                                ),
                                Column(
                                  children: [
                                    PetTextBox(controller: petName,
                                        hintText: "Pet Name"),
                                    PetTextBox(controller: species,
                                        hintText: "Species"),
                                    PetTextBox(
                                        controller: age, hintText: "Age"),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                )
                              ],
                            ),
                            //성별
                            Container(
                              height: 90.h,
                              color: Color(0xFFfbf3ec),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  SexButton(name: "male",
                                      isTrue: isMan,
                                      sexCheck: SexCheck),
                                  SexButton(name: "famale",
                                      isTrue: !isMan,
                                      sexCheck: SexCheck),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              width: double.infinity, // 화면 가로가 꽉 차게
                              height: 45.h,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (petId == "") { //생성하기
                                    await PostPets(
                                        petName.text, int.parse(age.text),
                                        species.text,
                                        isMan == true ? "MALE" : "FEMALE");
                                    widget.setScreen();
                                  }
                                  else { //수정하기
                                    await PutPetsType(petId!, petName.text,
                                        int.parse(age.text), species.text,
                                        isMan == true ? "MALE" : "FEMALE");
                                    petId="";
                                    widget.setScreen();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF06e88b9), // 파스텔 파란색
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // 테두리 둥글게
                                  ),
                                ),
                                child: Text('complete', style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontSize: 18.sp),),
                              ),
                            )
                          ]))))));
    }
  }
  void SexCheck(){
    setState(() {
      isMan=!isMan;
    });
  }
}
