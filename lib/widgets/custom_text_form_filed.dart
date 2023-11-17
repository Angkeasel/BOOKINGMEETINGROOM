import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';

class CustomTextFormFiled extends StatefulWidget {
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
  final TextInputAction textInputAction;
  final AutovalidateMode? autovalidateMode;
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
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode,
  });

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  late final controller = widget.controller ?? TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: textFieldBottomSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.title != null)
            Text(
              widget.title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          if (widget.title != null) const SizedBox(height: 5),
          SizedBox(
            height: widget.height,
            child: TextFormField(
              autovalidateMode: widget.autovalidateMode,
              textInputAction: widget.textInputAction,
              controller: widget.controller,
              onChanged: (value) {
                widget.onChanged?.call(value);
                setState(() {});
              },
              obscureText: widget.obscureText,

              validator: widget.validator,
              keyboardType: widget.keyboardType,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },

              style: textFieldTextStyle,
              // contextMenuBuilder: (context, editableTextState) =>
              //     AdaptiveTextSelectionToolbar.buttonItems(
              //   anchors: editableTextState.contextMenuAnchors,
              //   buttonItems: [
              //     ContextMenuButtonItem(
              //       onPressed: () {
              //         Clipboard.setData(
              //           ClipboardData(
              //               text: editableTextState.textEditingValue.text),
              //         );
              //       },
              //       label: 'Copy',
              //     ),
              //     ContextMenuButtonItem(
              //       onPressed: () async {
              //         controller.text =
              //             (await Clipboard.getData('text/plain'))?.text ?? '';
              //       },
              //       label: 'Paste',
              //     ),
              //   ],
              // ),
              decoration: InputDecoration(
                suffixIcon: widget.suffixIcon,
                hintText: widget.hintText,
                labelText: widget.lable,
                hintStyle: context.titleMedium,
                labelStyle: textFieldLabelStyle,
                enabledBorder: widget.isValidate
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: borderWidth,
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      )
                    : controller.text.isEmpty
                        ? OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          )
                        : OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: borderWidth,
                              // color: Color(0xffF1F1F1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: borderWidth,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: borderWidth,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabled: true,
                fillColor: controller.text.isEmpty
                    ? const Color(0xffF1F1F1)
                    : Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
