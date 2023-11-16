import 'package:flutter/material.dart';

class CustomLableEdit extends StatelessWidget {
  final IconData? icon;
  final String? lable;
  final Function()? onPressed;
  final TextStyle? style;
  const CustomLableEdit(
      {super.key, this.icon, this.lable, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: Colors.grey,
                  size: 24,
                )
              : Container(),
          SizedBox(
            width: icon != null ? 10 : 0,
          ),
          Text(
            '$lable',
            style: style ??
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.mode_edit_outlined,
              size: 20,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
