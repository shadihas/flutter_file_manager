import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_manager/injection.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/app_routes_names.dart';
import '../manager/get_files_cubit/get_files_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/empty_directory_widget.dart';
import '../widgets/file_card.dart'; 

class SubFolderPage extends StatelessWidget {
  String fileName;
  SubFolderPage({super.key, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<GetFilesCubit>()..getFiles(entityPath: fileName),
      child: Builder(builder: (context) {
        final fileManager = context.read<GetFilesCubit>();
        return SafeArea(
          child: Scaffold(
            body: BlocBuilder<GetFilesCubit, GetFilesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  success: (files) {
                    return files.isNotEmpty
                        ? SizedBox(
                            height: double.infinity,
                            child: Column(
                              children: [
                                CustomAppBar(
                                    fileManager: fileManager,
                                    // any file can do the job to get the parent directory
                                    file: files[0],
                                    fileName: fileName),
                                Expanded(
                                  child: SizedBox(
                                    child: ListView.builder(
                                      itemCount: files.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (files[index].isDirectory) {
                                              context.pushNamed(
                                                  AppRoutesNames.subFolder,
                                                  extra:
                                                      "$fileName/${files[index].name}");
                                            }
                                          },
                                          child: FileCard(
                                              file: files[index],
                                              fileManager: fileManager,
                                              fileName: fileName),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const EmptyDirectoryWidget();
                  },
                  orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}


