import 'dart:io';
import 'package:file_manager/file_manager.dart';
import 'package:flutter_file_manager/core/local_data/file_extensions.dart';
import 'package:flutter_file_manager/core/resources/resources.dart';

class FileManagerModel {
  String? image;
  String? name;
  String extension;
  DateTime? updateAt;
  int? size;
  bool isDirectory;
  FileSystemEntity? entity;
  FileManagerModel({ 
    required this.name,
    required this.image, 
    required this.extension, 
    required this.updateAt,
    required this.isDirectory,
    required this.size, 
    required this.entity, 
  });

  factory FileManagerModel.fromFileSystemEntity(
      FileSystemEntity entity, FileStat stat) {
    return FileManagerModel(
      name: FileManager.basename(entity),
      image: _getImagePath(entity),
      size:  _getSize(stat),
      extension: FileManager.isFile(entity)? FileManager.getFileExtension(entity): "",
      isDirectory: FileManager.isDirectory(entity),
      updateAt: _getUpdateAt(stat),
      entity: entity
    );
  }

  static DateTime _getUpdateAt(FileStat stat) {
    return stat.modified;
  }

  static int _getSize(FileStat stat) { 
    return stat.size;
  }

  static String _getImagePath(FileSystemEntity entity) {
    if (FileManager.isDirectory(entity)) {
      return AssetsManager.folder;
    }
    if (FileManager.isFile(entity)) {
      final extension = FileManager.getFileExtension(entity);

      if (FileExtensions.image.contains(extension)) {
        return AssetsManager.imageIcon;
      }

      if (FileExtensions.video.contains(extension)) {
        return AssetsManager.videoIcon;
      }
      if (FileExtensions.sound.contains(extension)) {
        return AssetsManager.soundIcon;
      }
      if (FileExtensions.document.contains(extension)) {
        return _handleDocumentExtension(extension);
      } else {
        return AssetsManager.imageIcon;
      }
    }
    return "";
  }

  static String _handleDocumentExtension(String extension) {
    String imagePath = "";
    switch (extension) {
      case "pdf":
        imagePath = AssetsManager.pdfIcon;
        break;
      case "docx":
        imagePath = AssetsManager.pdfIcon;
        break;
        // We can discuss the other options
      default:
        imagePath = AssetsManager.imageIcon;
    }
    return imagePath;
  }
  

}
