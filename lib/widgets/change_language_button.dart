import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/config/font/font_controller.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final lController = Get.find<LanguageController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            lController.toggleLanguage();
          },
          child: Ink(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(),
            ),
            child: Center(
              child: Text(
                lController.isKhmer ? 'English' : 'ភាសាខ្មែរ',
                style: context.labelLarge.copyWith(
                  fontVariations: [
                    FontWeight.w500.getVariant,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
