import 'package:flutter/material.dart';
import 'package:flutterwithapi2303122338/component/main_app_bar.dart';
import 'package:flutterwithapi2303122338/const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
        ],
      ),
    );
  }
}
