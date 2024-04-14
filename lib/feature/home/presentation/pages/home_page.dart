import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_manager/core/resources/resources.dart';
import 'package:flutter_file_manager/feature/home/presentation/manager/get_files_cubit/get_files_cubit.dart';
import 'package:flutter_file_manager/feature/home/presentation/widgets/empty_directory_widget.dart';
import 'package:flutter_file_manager/feature/home/presentation/widgets/file_card.dart';
import 'package:flutter_file_manager/injection.dart';
import 'package:flutter_file_manager/navigation/app_routes_names.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_progress_indicator.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/error_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetFilesCubit>()..getFiles(),
      child: Builder(builder: (context) {
        final fileManager = context.read<GetFilesCubit>();
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocBuilder<GetFilesCubit, GetFilesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  success: (files) {
                    return files.isNotEmpty
                        ? SizedBox(
                            height: 844.h,
                            child: Column(
                              children: [
                                CustomAppBar(
                                  fileManager: fileManager,
                                  // any file can do the job to get the parent directory
                                  file: files[0],
                                ),
                                Expanded(
                                  child: Container(
                                    padding: PaddingManager.paddingAll10,
                                    child: ListView.builder(
                                      itemCount: files.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (files[index].isDirectory) {
                                               context.pushNamed(
                                              AppRoutesNames.subFolder,
                                              extra:
                                                  files[index].name.toString(),
                                            );
                                            }
                                           
                                          },
                                          child: FileCard(
                                              file: files[index],
                                              fileManager: fileManager),
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
                  orElse: () => const appProgressIndicator(),
                  error: (error) =>
                      CustomErrorWidget(fileManager: fileManager, error: error),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
