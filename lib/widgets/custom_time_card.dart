import 'package:flutter/material.dart';

import 'package:meetroombooking/src/constant/app_color.dart';

class CustomTimeCard extends StatelessWidget {
  final String? time;
  final bool isSelected;
  final GestureTapCallback? onTap;
  const CustomTimeCard(
      {super.key, this.time, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          onTap: onTap,
          highlightColor: Colors.blue.withOpacity(0.4),
          splashColor: Colors.green.withOpacity(0.5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: !isSelected ? AppColors.primaryColor : Colors.grey,
            ),
            child: Center(
              child: Text(
                time ?? '',
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          )),
    );
  }
}
