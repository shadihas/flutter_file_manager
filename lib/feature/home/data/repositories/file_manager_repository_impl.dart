import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_file_manager/feature/home/data/data_sources/file_manager_data_source.dart';
import 'package:flutter_file_manager/feature/home/data/models/file_manager_model.dart';
import 'package:flutter_file_manager/feature/home/domain/repositories/file_manager_repository.dart';

@LazySingleton(as: FileManagerRepository)
class FileManagerRepositoryImp extends FileManagerRepository {
  final FileManagerDataSource _dataSource;
  FileManagerRepositoryImp(
    this._dataSource,
  );
  @override
  Future<Either<String, List<FileManagerModel>>> getFilesAndFolders(String fileName) async {
    try {
      final response = await _dataSource.getFilesAndFolders(fileName);
      return Right(response);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
