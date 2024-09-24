import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'asset/images/haca.png',
        height: 50,
      ),
      toolbarHeight: 56,
      backgroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
