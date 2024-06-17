import 'package:flutter/material.dart';
import 'package:pet/shopping/select_categoty_screen.dart';
import 'package:pet/shopping/select_item_screen.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  bool detail = false;

  void setdetail() {
    setState(() {
      detail = !detail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: detail
          ? SelectItemScreen(function: setdetail)
          : SelectCategoryscreen(function: setdetail),
    );
  }
}
