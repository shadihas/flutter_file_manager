import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/feature/home/presentation/widgets/title_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart'; 
import '../../../../core/resources/spaces_manager.dart';
import '../../data/models/file_manager_model.dart';
import '../manager/get_files_cubit/get_files_cubit.dart'; 
import 'create_folder_dialog.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.fileManager,
    required this.file,
    this.fileName = "",
  });

  final GetFilesCubit fileManager;
  final FileManagerModel file;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      height: 50.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.canPop()
              ? IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back_rounded))
              : SpacesManager.w10,
          TitleText(title: fileName.isEmpty ? "File Manager" : fileName,),
          Row(
            children: [
              PopupMenuButton(
                icon: const Icon(Icons.sort),
                itemBuilder: (BuildContext context) {
                  return sortByButtons(context);
                },
              ),
              IconButton(
                  onPressed: () { 
                    createFolder(
                      entityPath: fileName,
                      getFileContext: context, 
                      entityFullPath: file.entity!.parent.path,
                    );
                  },
                  icon: const Icon(Icons.create_new_folder_outlined)),
            ],
          )
        ],
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> sortByButtons(BuildContext context) {
    return <PopupMenuEntry>[
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            sortBy(context, SortBy.name);
                          },
                          child: const Text("name"))),
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            sortBy(context, SortBy.date);
                          },
                          child: const Text("date"))),
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            sortBy(context, SortBy.size);
                          },
                          child: const Text("size"))),
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                          sortBy(context, SortBy.type);
                          },
                          child: const Text("type"))),
                ];
  }

  void sortBy(BuildContext context, SortBy sortBy) {
    fileManager.getFiles(
        entityPath: fileName, sortBy: sortBy);
    context.pop();
  }

}
