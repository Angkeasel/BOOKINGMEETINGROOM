import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';

import '../src/constant/app_color.dart';

class CustomButtons extends StatelessWidget {
  final String? title;
  final bool? isOutline;
  final bool? isDisabled;
  final IconData? icon;
  final String? iconSvg;
  final GestureTapCallback? onTap;
  final Color? color;
  final Color? textColor;
  final double? width;
  const CustomButtons({
    Key? key,
    this.title,
    this.isOutline = false,
    this.isDisabled = false,
    this.icon,
    this.iconSvg,
    this.onTap,
    this.color,
    this.width,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: context.width > 500
              ? width ?? context.width * .3
              : double.infinity),
      child: Material(
        color: isOutline == true
            ? Colors.transparent
            : isDisabled == true
                ? Colors.grey
                : color ?? AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isDisabled == true ? null : onTap,
          splashColor: isOutline == true
              ? AppColors.primaryColor.withOpacity(0.4)
              : null,
          highlightColor: isOutline == true
              ? AppColors.primaryColor.withOpacity(0.4)
              : null,
          focusColor: isOutline == true
              ? AppColors.primaryColor.withOpacity(0.4)
              : null,
          child: Container(
            //height: 50,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            // width: width ?? double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: isOutline == true
                  ? isDisabled == true
                      ? Border.all(color: Colors.grey)
                      : Border.all(color: color ?? AppColors.primaryColor)
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          icon,
                          color: AppColors.primaryColor,
                        ),
                      )
                    : iconSvg != null
                        ? SvgPicture.asset("$iconSvg")
                        : const SizedBox(),
                icon != null || iconSvg != null
                    ? const SizedBox(width: 10)
                    : const SizedBox(),
                Text(title ?? '',
               
                    textAlign: TextAlign.center,
                    style: context.bodyMedium.copyWith(
                        fontSize: 16,
                        fontVariations: [FontWeight.w600.getVariant],
                        color: isOutline == true
                            ? color ?? AppColors.primaryColor
                            : textColor ?? Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
