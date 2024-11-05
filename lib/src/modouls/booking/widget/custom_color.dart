import 'package:flutter/material.dart';
import 'package:meetroombooking/src/util/extension/colors.dart';

class CustomColor extends StatelessWidget {
  final bool isSelected;
  final String? colors;

  const CustomColor({super.key, this.isSelected = false, this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 50,
      width: 50,
      decoration:
          BoxDecoration(color: colors?.toColor(), shape: BoxShape.circle),
      child: isSelected
          ? const Icon(
              Icons.check,
              color: Colors.white,
            )
          : Container(),
    );
  }
}
