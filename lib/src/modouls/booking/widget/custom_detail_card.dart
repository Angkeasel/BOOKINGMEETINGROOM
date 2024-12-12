import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

class CustomDetailCard extends StatelessWidget {
  final String? text;
  final String? lable;
  final IconData icon;
  const CustomDetailCard(
      {super.key, this.lable, this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Icon(
            icon,
            size: 50,
            color: AppColors.secondaryColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text ?? '',
                 overflow: TextOverflow.clip,
              ),
              Text(
                lable ?? '',
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
