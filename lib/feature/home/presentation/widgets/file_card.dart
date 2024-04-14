import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_manager/feature/home/data/models/file_manager_model.dart';
import 'package:flutter_file_manager/feature/home/presentation/widgets/sub_title_text.dart';
import 'package:flutter_file_manager/feature/home/presentation/widgets/title_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/resources.dart';
import '../manager/get_files_cubit/get_files_cubit.dart';

class FileCard extends StatelessWidget {
  const FileCard(
      {super.key,
      required this.file,
      required this.fileManager,
      this.fileName = ""});
  final FileManagerModel file;
  final String fileName;
  final GetFilesCubit fileManager;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            file.image.toString(),
            height: 55.w,
          ),
          SizedBox(
            width: 200.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(title: file.name.toString()),
                SpacesManager.h10,       
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubTitleText(
                        text: file.updateAt.toString().substring(0, 10)),
                    SpacesManager.w30,
                    SubTitleText(
                      text: FileManager.formatBytes(file.size!),
                    ),
                  ],
                ),
              
              ],
            ),
          ),
          SpacesManager.w30, 
          PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  deleteMenuItem(context),
                  editMenuItem(context),
                ];
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> deleteMenuItem(BuildContext context) {
    return PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: () {
                          context.pop();
                          fileManager.delete(
                              entityPath: fileName, entityName: file.entity!);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        label: const Text("delete")));
  }

  PopupMenuItem<dynamic> editMenuItem(BuildContext context) {
    return PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: () {
                          context.pop(); 
                          renameDialog(getFileContext: context);
                        },
                        icon: const Icon(
                          Icons.drive_file_rename_outline_outlined,
                          color: Colors.black,
                        ),
                        label: const Text("edit")));
  }

  void renameDialog({required BuildContext getFileContext}) {
    showDialog(
      context: getFileContext,
      builder: (context) {
        TextEditingController renameController = TextEditingController();
        return AlertDialog(
          title: Text("Rename ${FileManager.basename(file.name)}"),
          content: TextField(
            controller: renameController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                context.pop();
                getFileContext.read<GetFilesCubit>().rename(
                    entityPath: fileName,
                    entityName: file.entity!,
                    fileExtension: file.extension,
                    fileName: renameController.text,
                    folderPath: file.entity!.parent.path);
              },
              child: const Text("Rename"),
            ),
          ],
        );
      },
    );
  }
}
