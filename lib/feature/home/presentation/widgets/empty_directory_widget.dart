import 'package:flutter/material.dart';
import 'package:flutter_file_manager/feature/home/presentation/widgets/title_text.dart';

class EmptyDirectoryWidget extends StatelessWidget {
  const EmptyDirectoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 800,
      child: const TitleText(title: "Empty directory"),
    );
  }
}