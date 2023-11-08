import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

class CustomTextFormFiled extends StatelessWidget {
  final String? lable;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const CustomTextFormFiled(
      {super.key,
      this.lable,
      this.hintText,
      this.controller,
      this.onChanged,
      this.suffixIcon,
      this.obscureText = false,
      this.validator,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              enabledBorder: OutlineInputBorder(
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
    );
  }
}
