import 'dart:io'; 
import 'package:dartz/dartz.dart';
import 'package:flutter_file_manager/feature/home/data/models/file_manager_model.dart';
import 'package:flutter_file_manager/feature/home/domain/repositories/file_manager_repository.dart';
import 'package:flutter_file_manager/feature/home/domain/use_cases/get_file_manager_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFileManagerRepository extends Mock implements FileManagerRepository {}

void main() async {
  late GetFileManagerUseCase getFileManagerUseCase;
  late MockFileManagerRepository mockRepository;
  final entities = await Directory("/").list().toList();

  setUp(() {
    mockRepository = MockFileManagerRepository();
    getFileManagerUseCase = GetFileManagerUseCase(mockRepository);
  });

  group('GetFileManagerUseCase', () {
    test('returns list of FileManagerModel from repository', () async {
      // Arrange
      const fileName = 'example.txt';
      final mockResponse = <FileManagerModel>[
        FileManagerModel(
            name: 'file1',
            updateAt: DateTime(DateTime.january),
            image: 'image1',
            size: 100,
            entity: entities[0],
            extension: "pdf",
            isDirectory: false),
        FileManagerModel(
            name: 'file2',
            updateAt: DateTime(DateTime.february),
            image: 'image2',
            size: 200,
            entity: entities[1],
            extension: "",
            isDirectory: true),
      ];
      when(() => mockRepository.getFilesAndFolders(fileName))
          .thenAnswer((_) async => Right(mockResponse));

      // Act
      final result = await getFileManagerUseCase(fileName);

      // Assert
      expect(result, equals(Right(mockResponse)));
      verify(() => mockRepository.getFilesAndFolders(fileName)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('returns error from repository', () async {
      // Arrange
      const fileName = 'example.txt';
      const errorMessage = 'Error occurred';
      when(() => mockRepository.getFilesAndFolders(fileName))
          .thenAnswer((_) async => const Left(errorMessage));

      // Act
      final result = await getFileManagerUseCase(fileName);

      // Assert
      expect(result, equals(const Left(errorMessage)));
      verify(() => mockRepository.getFilesAndFolders(fileName)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
