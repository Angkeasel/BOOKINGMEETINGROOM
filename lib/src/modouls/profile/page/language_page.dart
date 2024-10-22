import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';

import '../../../config/font/font_controller.dart';
import '../../../constant/app_color.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedOption = 'test';
  final lController = Get.find<LanguageController>();
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
      body: Column(
        children: [
          //Text('testing $selectedOption'),
          ListTile(
            title: const Text('Khmer'),
            leading: Radio<String>(
              value: lController.isKhmer ? 'English' : 'ភាសាខ្មែរ',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  debugPrint("Button value: $value");
                });
              },
            ),
          ),
          ListTile(
            title: const Text('EngLish'),
            leading: Radio<String>(
              value: lController.isKhmer ? 'English' : 'ភាសាខ្មែរ',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  debugPrint("Button value: $value");
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
