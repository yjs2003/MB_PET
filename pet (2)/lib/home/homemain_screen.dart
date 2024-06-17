import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet/common/component/url.dart';
import '../common/basic.dart';
import '../common/provider.dart';
import 'component/myprofile.dart';
import 'component/pet_container.dart';
import 'component/pet_details.dart';

// 홈 화면의 상태를 관리하는 StateNotifier
class HomeMainScreenNotifier extends StateNotifier<bool> {
  HomeMainScreenNotifier() : super(false);

  void toggleDetail() {
    state = !state;
  }
}

final homeMainScreenProvider =
StateNotifierProvider((ref) => HomeMainScreenNotifier());

class HomeMainScreen extends ConsumerWidget {
  final VoidCallback setScreen;

  const HomeMainScreen({
    required this.setScreen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsAsyncValue = ref.watch(homeProvider);
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Center(
            child: petsAsyncValue.when(
              data: (pets) {
                print("홈1$petId");
                if(pets.length>0&& petId=="")
                  petId = pets[0].id;
                print("홈2$petId");
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyProfile(
                          color: Color(0xFFfae186),
                          title: "Hi, ${nickname}!",
                          procon: "👩🏻‍🦰",
                        ),
                        nickname=="suins"||nickname=="zzzzzz"?
                        Icon(Icons.verified,color: Colors.blue,):Container()
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Your Pets",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 90.h, // 적절한 높이 설정
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                            onTap: () {
                              petId = "";
                              setScreen();
                            },
                            child: PetContainer(
                              petcon: '+',
                              color: Color(0xFFd1e7fc),
                              content: 'ADD_Pet',
                            ),
                          ),
                          Row(
                            children: pets.map((pet) {
                              return InkWell(
                                onTap: () {
                                  petId = pet.id;
                                  ref.refresh(homeProvider);
                                },
                                child: PetContainer(
                                  content: pet.name,
                                  petcon: pet.species == "DOG" ? '🐶' : '🐱',
                                  color: Color(0xFFecfbc7),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    pets.length > 0
                        ? PetDetail(
                      setScreen: setScreen,
                    )
                        : Container(),
                  ],
                );
              },
              loading: () =>Container(height: 360.h,
                child:
                  Center(
                child: CircularProgressIndicator(),
                  )),
              error: (error, stack) => Text('Error: $error'),
            ),
          ),
        ),
      ),
    );
  }
}
 