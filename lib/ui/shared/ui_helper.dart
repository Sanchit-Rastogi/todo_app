import 'package:flutter/material.dart';

class UIHelper {
  static const Widget verticalSpaceSmall = SizedBox(height: 8);
  static const Widget verticalSpaceMedium = SizedBox(height: 16);
  static const Widget verticalSpaceLarge = SizedBox(height: 32);

  static const Widget horizontalSpaceSmall = SizedBox(width: 8);
  static const Widget horizontalSpaceMedium = SizedBox(width: 16);
  static const Widget horizontalSpaceLarge = SizedBox(width: 32);

  static Widget verticalSpace(double height) => SizedBox(height: height);
  static Widget horizontalSpace(double width) => SizedBox(width: width);
}
