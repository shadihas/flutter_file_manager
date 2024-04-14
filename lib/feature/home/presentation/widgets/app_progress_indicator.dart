import 'package:flutter/material.dart';

class appProgressIndicator extends StatelessWidget {
  const appProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
