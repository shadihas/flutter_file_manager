import 'dart:io';
import 'package:flutter_file_manager/feature/home/data/models/file_manager_model.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/local_data/paths.dart';

@singleton
class FileManagerDataSource {
  Future<List<FileManagerModel>> getFilesAndFolders(
      [String fileName = ""]) async {
    List<FileManagerModel> files = [];

     await requestPermissions();

    if (Platform.isAndroid) {
      final directory = Directory(Paths.androidPath + fileName);
      final fileSystemEntities = directory.listSync();
      for (var entity in fileSystemEntities) {
        FileStat stat = await entity.stat();
        files.add(FileManagerModel.fromFileSystemEntity(entity, stat));
      }
    }
    return files;
  }
}

Future<void> requestPermissions() async {
  final permissions = [
    Permission.accessMediaLocation,
    Permission.manageExternalStorage,
    Permission.storage,
  ];

  for (var permission in permissions) {
    if (await permission.isDenied) {
      await permission.request();
    }
  }
}
