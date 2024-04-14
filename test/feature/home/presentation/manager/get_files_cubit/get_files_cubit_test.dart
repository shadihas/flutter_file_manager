import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_file_manager/feature/home/data/models/file_manager_model.dart';
import 'package:flutter_file_manager/feature/home/domain/use_cases/get_file_manager_use_case.dart';
import 'package:flutter_file_manager/feature/home/presentation/manager/get_files_cubit/get_files_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockGetFileManagerUseCase extends Mock implements GetFileManagerUseCase {}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  late GetFileManagerUseCase mockGetFileManagerUseCase;
  late GetFilesCubit getFilesCubit;
 final entities = await Directory("/").list().toList();
 
 setUp(() {
    mockGetFileManagerUseCase = MockGetFileManagerUseCase();
    getFilesCubit = GetFilesCubit(mockGetFileManagerUseCase);
  });
  group('GetFilesCubit', () {
   
    List<FileManagerModel> fileManagerModelList = [
      FileManagerModel(name: 'file1', updateAt: DateTime(DateTime.january), image: 'image1', size: 100,entity: entities[0], extension: "pdf",isDirectory: false),
      FileManagerModel(name: 'file2', updateAt: DateTime(DateTime.february), image: 'image2', size: 200, entity: entities[1], extension: "", isDirectory: true),
    ];

    blocTest<GetFilesCubit, GetFilesState>(
      'emits [loading, then success] when getFiles is called successfully',
      build: () { 
          when(() => mockGetFileManagerUseCase(any())).thenAnswer((_) async => Right(fileManagerModelList));
           return getFilesCubit; 
       
      },
      act: (cubit) => cubit.getFiles(),
      expect: () => [
        const GetFilesState.loading(),
        GetFilesState.success(files: fileManagerModelList),
      ],
    );

    blocTest<GetFilesCubit, GetFilesState>(
      'emits [loading, then error] when getFiles throws an error',
      build: () {
        when(() => mockGetFileManagerUseCase(any())).thenAnswer((_) async => const Left('Error'));
        return getFilesCubit;
      },
      act: (cubit) => cubit.getFiles(),
      expect: () => [
        const GetFilesState.loading(),
        const GetFilesState.error(error: 'Error'),
      ],
    ); 
  });
}

