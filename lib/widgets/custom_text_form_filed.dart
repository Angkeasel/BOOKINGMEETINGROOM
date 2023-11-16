import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

class CustomTextFormFiled extends StatelessWidget {
  final String? title;
  final String? lable;
  final String? hintText;
  final double? height;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isValidate;
  const CustomTextFormFiled({
    super.key,
    this.title,
    this.lable,
    this.height,
    this.hintText,
    this.controller,
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.isValidate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: title != null ? 5 : 0,
          ),
          SizedBox(
            height: height,
            child: TextFormField(
                controller: controller,
                onChanged: onChanged,
                obscureText: obscureText,
                validator: validator,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                    suffixIcon: suffixIcon,
                    hintText: hintText,
                    label: Text(
                      "$lable",
                    ),
                    labelStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    enabledBorder: isValidate
                        ? OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10))
                        : OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color(0xffF1F1F1),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                    enabled: true,
                    fillColor: const Color(0xffF1F1F1),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(10)))),
          ),
        ],
      ),
    );
  }
}
