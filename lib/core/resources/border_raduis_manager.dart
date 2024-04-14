import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderRadiusManager {
  BorderRadiusManager._();
  static final BorderRadius radiusAll10 = BorderRadius.circular(10).r;
  static final BorderRadius radiusAll15 = BorderRadius.circular(15).r;
  static final BorderRadius radiusAll20 = BorderRadius.circular(20).r;
  static final BorderRadius radiusAll30 = BorderRadius.circular(30).r;
  static final BorderRadius radiusAll40 = BorderRadius.circular(40).r;
  static final BorderRadius radiusBottom40  =
      const BorderRadius.vertical(bottom: Radius.circular(40)).r;
  static final BorderRadius radiusBottomLeft40  =
      const BorderRadius.only(bottomLeft: Radius.circular(40)).r;
  static final BorderRadius radiusTop30  =
      const BorderRadius.vertical(top: Radius.circular(30)).r;
  static final BorderRadius radiusLeft20  =
      const BorderRadius.horizontal(left: Radius.circular(20)).r;
  static final BorderRadius radiusLeft10  =
      const BorderRadius.horizontal(left: Radius.circular(10)).r;
  static final BorderRadius radiusLeft40  =
      const BorderRadius.horizontal(left: Radius.circular(40)).r;
  static final BorderRadius radiusTopLeft30  =
      const BorderRadius.only(topLeft: Radius.circular(30)).r;
}
