import 'package:flutter/material.dart';
import 'package:sia/core/constants/app_colors.dart';
import 'package:sia/core/theme/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Home Screen',
          style: AppTextStyles.largeTitle(color: AppColors.primaryDark),
        )
      ),
    );
  }
}
