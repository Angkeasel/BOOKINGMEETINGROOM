import 'dart:ui';

const padding = 16.0;
const textFieldBottomSpacing = 20.0;

const borderWidth = 0.8;

extension FW on FontWeight {
  FontVariation get getVariant => FontVariation('wght', value.toDouble());
}
