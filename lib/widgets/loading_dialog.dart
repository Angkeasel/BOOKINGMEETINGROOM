import 'package:flutter/material.dart';

BuildContext? _loadingContext;

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (_) {
      _loadingContext = _;
      return const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.red,
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
