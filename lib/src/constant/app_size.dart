import 'package:flutter/material.dart';

const padding = 16.0;
const textFieldBottomSpacing = 20.0;

const borderWidth = 0.9;

const defaultMinSafeArea = EdgeInsets.only(bottom: 20);

extension FW on FontWeight {
  FontVariation get getVariant => FontVariation('wght', value.toDouble());
}
