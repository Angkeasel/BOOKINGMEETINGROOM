import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

BuildContext? _loadingContext;

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (_) {
      _loadingContext = _;
      return PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
            // backgroundColor: Colors.grey.shade800,
          ),
        ),
      );
    },
  );
}

void removeLoading() {
  if (_loadingContext != null && _loadingContext?.mounted == true) {
    Navigator.of(_loadingContext!, rootNavigator: true).pop();
  }
}
