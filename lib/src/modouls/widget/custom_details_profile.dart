import 'package:flutter/material.dart';

class CustomDetailProfile extends StatelessWidget {
  final String? lable;
  final String? value;
  final bool? icons;
  const CustomDetailProfile(
      {super.key, this.lable, this.value, this.icons = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$lable'),
          icons!
              ? const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )
              : Text('$value')
        ],
      ),
    );
  }
}
