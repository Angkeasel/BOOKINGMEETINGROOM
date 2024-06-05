import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

class CustomListingRoom extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final bool isClick;
  const CustomListingRoom(
      {super.key, this.title, this.onTap, this.isClick = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
              color: isClick ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isClick ? Colors.white : AppColors.primaryColor,
              )),
          padding: const EdgeInsets.all(15),
          child: Center(
              child: Text(
            title ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )),
        ),
      ),
    );
  }
}
