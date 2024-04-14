import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
       maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: appFontStyle(
          fontSize: FontSizesManager.s14, color: ColorManager.black),
    );
  }
}
