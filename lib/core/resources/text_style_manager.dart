import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle({
  required double fontSize,
  required FontWeight fontWeight, 
  double? height,
  Color? color,
}) =>
    TextStyle( 
      color: color,
      fontWeight: fontWeight, 
      fontSize: fontSize,
      overflow: TextOverflow.fade,
      height: height,
    );

TextStyle? appFontStyle({
  required double fontSize,
  required Color color,
  FontWeight fontWeight = FontWeightManager.bold,
}) =>
    _getTextStyle( 
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );

TextStyle? buttonText({
  required Color color,
   double fontSize = FontSizesManager.s16,
   FontWeight fontWeight =  FontWeightManager.semiBold,
   
}) =>
    _getTextStyle( 
      fontSize: fontSize,
      fontWeight:fontWeight,
      color: color,
    );
