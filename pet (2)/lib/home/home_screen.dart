import 'package:flutter/material.dart';
import 'package:pet/home/homemain_screen.dart';
import 'package:pet/home/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool detail = false;
  @override
  Widget build(BuildContext context) {
    if(detail==false) {
      return HomeMainScreen(setScreen: setScreen);
    }
    else {
      return ProfileScreen(setScreen: setScreen);
    }
  }
  void setScreen(){
    setState(() {
      detail=!detail;
    });
  }
}
