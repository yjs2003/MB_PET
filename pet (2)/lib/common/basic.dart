import 'package:flutter/material.dart';
import 'package:pet/comunity/comunity_screen.dart';
import 'package:pet/home/home_screen.dart';
import 'package:pet/shopping/select_categoty_screen.dart';
import 'package:pet/shopping/shoppingScreen.dart';
import 'package:flutter_screenutil/src/screen_util.dart';

import '../home/component/remove_button.dart';
import 'component/url.dart';

class Basic extends StatefulWidget {

  const Basic({super.key});

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> with SingleTickerProviderStateMixin {

  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener(){
    setState(() {
      index=controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.lightGreen,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: (int index) {
            petId="";
            isRemove=false;
            controller.animateTo(index);
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.pets_outlined), label: 'HOME'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined), label: 'NETWORK'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'STORE'),
          ],
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),//좌우이동은안됨.
          controller: controller,
          children: [
            HomeScreen(),
            ComunityScreen(),
            ShoppingScreen()
          ],
        ));
  }
}
