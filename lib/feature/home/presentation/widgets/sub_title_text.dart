import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: appFontStyle(
          fontSize: FontSizesManager.s12, color: ColorManager.lightGrey),
    );
  }
}
