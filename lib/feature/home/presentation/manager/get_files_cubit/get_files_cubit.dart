import 'dart:io'; 
import 'package:bloc/bloc.dart';
import 'package:file_manager/file_manager.dart';
import 'package:file_manager/helper/helper.dart';
import 'package:flutter_file_manager/feature/home/data/models/file_manager_model.dart';
import 'package:flutter_file_manager/feature/home/domain/use_cases/get_file_manager_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart'; 
part 'get_files_cubit.freezed.dart';
part 'get_files_state.dart';

@injectable
class GetFilesCubit extends Cubit<GetFilesState> {
  GetFileManagerUseCase getFileManagerUseCase;
  GetFilesCubit(
    this.getFileManagerUseCase,
  ) : super(const GetFilesState.initial());

  getFiles({String entityPath = "", SortBy sortBy = SortBy.date}) async {
    emit(const GetFilesState.loading()); 
      final response = await getFileManagerUseCase(entityPath);
      response.fold((error) => emit(GetFilesState.error(error: error)),
          (files) {
        _sortBy(files: files, sortBy: sortBy);
        emit(GetFilesState.success(
          files: files,
        ));
      });
    
  }

  delete({required FileSystemEntity entityName, String entityPath = ""}) async {
    await entityName
        .delete(recursive: true)
        .then((value) => getFiles(entityPath: entityPath));
  }

  Future<void> rename(
      {required String folderPath,
      String entityPath = "",
      required FileSystemEntity entityName,
      required String fileName,
      required String fileExtension}) async { 
    fileExtension == ""
        ? await _renameFolder(entityName, folderPath, fileName, entityPath)
        : await _renameFile(
            entityName, folderPath, fileName, fileExtension, entityPath);
  }

  Future<void> createFolder({
    required String entityName,
    required String entityFullPath,
    String entityPath = "",
  }) async {
    await Directory("$entityFullPath/$entityName")
        .create()
        .then((value) => getFiles(entityPath: entityPath));
  }

  Future<void> _renameFile(FileSystemEntity entityName, String folderPath,
      String fileName, String fileExtension, String entityPath) async {
    return await entityName
        .rename('$folderPath/$fileName' ".$fileExtension")
        .then((value) => getFiles(entityPath: entityPath));
  }

  Future<void> _renameFolder(FileSystemEntity entityName, String folderPath,
      String fileName, String entityPath) async {
    return await entityName
        .rename('$folderPath/$fileName')
        .then((value) => getFiles(entityPath: entityPath));
  }

  void _sortBy(
      {required List<FileManagerModel> files, required SortBy sortBy}) {
    switch (sortBy) {
      case SortBy.name:
        files.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        break;
      case SortBy.size:
        files.sort((a, b) {
          return a.size!.compareTo(b.size!);
        });
        break;
      case SortBy.date:
        files.sort((a, b) {
          return a.updateAt!.compareTo(b.updateAt!);
        });
        break;
      case SortBy.type:
        files.sort((a, b) {
          return a.image!.compareTo(b.image!);
        });
        break;
    }
  }
}


