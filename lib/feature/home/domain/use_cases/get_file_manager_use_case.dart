

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_file_manager/core/use_case/use_case.dart';
import 'package:flutter_file_manager/feature/home/data/models/file_manager_model.dart';
import 'package:flutter_file_manager/feature/home/domain/repositories/file_manager_repository.dart';

@injectable
class GetFileManagerUseCase extends UseCase<List< FileManagerModel>, String> {
  final FileManagerRepository _fileManagerRepository;
  GetFileManagerUseCase( this._fileManagerRepository, );
  @override
  Future<Either<String, List< FileManagerModel>>> call(fileName)async {
   final response = await _fileManagerRepository.getFilesAndFolders(fileName);
   return response; 
  }

}
