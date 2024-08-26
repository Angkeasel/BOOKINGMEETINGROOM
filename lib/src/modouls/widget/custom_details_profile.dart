import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

class CustomDetailProfile extends StatefulWidget {
  final String? lable;
  bool valueSwich;
  final bool icons;
  final bool isText;
  final IconData? iconData;
  final String? language;
  final Function()? onTap;

  CustomDetailProfile(
      {super.key,
      this.lable,
      this.valueSwich = false,
      this.icons = false,
      this.isText = false,
      this.language,
      this.iconData,
      this.onTap});

  @override
  State<CustomDetailProfile> createState() => _CustomDetailProfileState();
}

class _CustomDetailProfileState extends State<CustomDetailProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              widget.iconData,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text('${widget.lable}'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                widget.isText ? widget.language ?? '' : '',
                style: TextStyle(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w600),
              ),
            ),
            widget.icons
                ? const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  )
                : Transform.scale(
                    scale: 0.9,
                    child: Switch(
                        value: widget.valueSwich,
                        onChanged: (v) {
                          setState(() {
                            widget.valueSwich = v;
                          });
                          debugPrint('========> ${widget.valueSwich}');
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
