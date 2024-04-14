// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_file_manager/feature/home/data/data_sources/file_manager_data_source.dart'
    as _i3;
import 'package:flutter_file_manager/feature/home/data/repositories/file_manager_repository_impl.dart'
    as _i5;
import 'package:flutter_file_manager/feature/home/domain/repositories/file_manager_repository.dart'
    as _i4;
import 'package:flutter_file_manager/feature/home/domain/use_cases/get_file_manager_use_case.dart'
    as _i6;
import 'package:flutter_file_manager/feature/home/presentation/manager/get_files_cubit/get_files_cubit.dart'
    as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.FileManagerDataSource>(() => _i3.FileManagerDataSource());
    gh.lazySingleton<_i4.FileManagerRepository>(
        () => _i5.FileManagerRepositoryImp(gh<_i3.FileManagerDataSource>()));
    gh.factory<_i6.GetFileManagerUseCase>(
        () => _i6.GetFileManagerUseCase(gh<_i4.FileManagerRepository>()));
    gh.factory<_i7.GetFilesCubit>(
        () => _i7.GetFilesCubit(gh<_i6.GetFileManagerUseCase>()));
    return this;
  }
}
