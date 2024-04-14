import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/resources.dart';
import '../manager/get_files_cubit/get_files_cubit.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.fileManager,
    required this.error,
  });

  final GetFilesCubit fileManager;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 600.h,
        child: Column(
          children: [
            Text(error),
            SpacesManager.h20,
            FilledButton(
                onPressed: () {
                  fileManager.getFiles();
                },
                child: const Text("request permission"))
          ],
        ),
      ),
    );
  }
}
