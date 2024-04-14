import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_manager/core/resources/color_manager.dart';
import 'package:flutter_file_manager/feature/home/presentation/manager/get_files_cubit/get_files_cubit.dart';
import 'package:go_router/go_router.dart';

class CreateFolderDialog extends StatelessWidget {
  CreateFolderDialog(
      {super.key,
      required this.entityFullPath,
      required this.entityPath,
      required this.getFileContext});
  final String entityFullPath;
  final String entityPath;
  final folderName = TextEditingController();
  final BuildContext getFileContext;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Builder(builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: TextField(
                  decoration: const InputDecoration(
                    hintText: "Folder Name",
                    hintStyle: TextStyle(
                      color: ColorManager.grey,
                    ),
                  ),
                  controller: folderName,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (folderName.text.isEmpty || folderName.text == "") {
                  } else {
                    context.pop();
                    getFileContext.read<GetFilesCubit>().createFolder( 
                        entityName: folderName.text,
                        entityFullPath: entityFullPath,
                        entityPath: entityPath);
                  }
                },
                child: const Text(
                  'Create Folder',
                  style: TextStyle(
                    color: ColorManager.darkGrey,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

createFolder(
    {required BuildContext getFileContext,
    required String entityFullPath,
    String entityPath = ""}) async {
  showDialog(
    context: getFileContext,
    builder: (context) {
      return CreateFolderDialog(
          getFileContext: getFileContext,
          entityFullPath: entityFullPath,
          entityPath: entityPath);
    },
  );
}