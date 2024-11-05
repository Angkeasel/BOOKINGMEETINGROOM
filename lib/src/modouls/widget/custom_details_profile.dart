import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/config/font/font_controller.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

class CustomDetailProfile extends StatelessWidget {
  final String? lable;

  final bool icons;
  final bool isText;
  final IconData? iconData;
  final String? language;
  final Function()? onTap;

  CustomDetailProfile(
      {super.key,
      this.lable,
      this.icons = false,
      this.isText = false,
      this.language,
      this.iconData,
      this.onTap});

  final lController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              iconData,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              '$lable',
              style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w600),
            )),
            const Spacer(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  isText ? language! : '',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            icons
                ? const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColors.secondaryColor,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
