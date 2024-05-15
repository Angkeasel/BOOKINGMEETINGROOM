import 'package:flutter/material.dart';

import '../../../../main.dart';

const txt12 = TextStyle(
  fontSize: 12,
  fontFamily: "Battambang-Regular",
  fontWeight: FontWeight.w500,
  color: Colors.grey,
);
const txt14 = TextStyle(
  fontSize: 14,
  fontFamily: "Battambang-Regular",
  fontWeight: FontWeight.w500,
  color: Colors.grey,
);
void alertErrorSnackbar({
  required title,
  required message,
}) {
  final SnackBar snackBarError = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    margin: const EdgeInsets.all(10),
    duration: const Duration(milliseconds: 1600),
    behavior: SnackBarBehavior.floating,
    content: SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: txt14.copyWith(color: Colors.white),
              ),
              Text(
                message,
                overflow: TextOverflow.ellipsis,
                style: txt12.copyWith(color: Colors.white),
              ),
            ],
          ),
          const Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ],
      ),
    ),
    backgroundColor: Colors.red,
  );
  snackBarKey.currentState?.showSnackBar(snackBarError);
}
