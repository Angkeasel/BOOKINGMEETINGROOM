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

BuildContext? dialogContext;
showDialogConfirmation({
  required BuildContext context,
  required String txt,
  required String accept,
  required String? cancel,
  GestureTapCallback? onTapCancel,
  GestureTapCallback? onTap,
}) async {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        titlePadding: const EdgeInsets.only(top: 20, bottom: 0),
        // insetPadding: const EdgeInsets.symmetric(horizontal: 0),
        // actionsPadding: const EdgeInsets.all(20),
        // contentPadding:
        //     const EdgeInsets.only(left: 28, right: 28, top: 15, bottom: 5),
        title: const Text(
          "Confirm",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        content: Text(
          "Are you sure, you want to $txt ?",
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        // contentTextStyle: const TextStyle(
        //   fontSize: 13,
        //   fontWeight: FontWeight.w500,
        //   color: Colors.black,
        // ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(dialogContext);
              onTapCancel?.call();
            },
            child: Text(
              cancel ?? 'Cancel',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              accept,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    },
  );
}
