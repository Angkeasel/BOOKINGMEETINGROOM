import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';

import '../../../constant/app_color.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Language",
        ),
        titleTextStyle: context.appBarTextStyle.copyWith(
          color: AppColors.textLightColor,
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
