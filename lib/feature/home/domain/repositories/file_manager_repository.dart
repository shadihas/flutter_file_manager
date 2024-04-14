

import 'package:dartz/dartz.dart';
import 'package:flutter_file_manager/feature/home/data/models/file_manager_model.dart';

abstract class FileManagerRepository{
  Future<Either<String, List< FileManagerModel>>> getFilesAndFolders(String fileName);
}