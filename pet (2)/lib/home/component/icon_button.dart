import 'package:flutter/material.dart';

class IconButtons extends StatelessWidget {
  final Widget icons;
  final VoidCallback onPressed;
  const IconButtons({
    required this.icons,
    required this.onPressed,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.3), // 회색 테두리
        borderRadius: BorderRadius.circular(8.0), // 둥근 모서리
      ),
      child: IconButton(
        onPressed:onPressed,
        icon: icons
      ),
    );
  }
}
