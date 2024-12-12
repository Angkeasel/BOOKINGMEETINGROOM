import 'package:flutter/material.dart';

import '../src/constant/app_color.dart';

class CustomLableEdit extends StatelessWidget {
  final IconData? icon;
  final String? lable;
  final Function()? onPressed;
  final TextStyle? style;
  const CustomLableEdit(
      {super.key, this.icon, this.lable, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        icon,
                        color: Colors.grey,
                        size: 24,
                      ),
                    )
                  : Container(),
              Expanded(
                child: Text(
                  '$lable',
                  style: style ??
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.mode_edit_outlined,
            size: 20,
            color: AppColors.secondaryColor,
          ),
        )
      ],
    );
  }
}
