part of 'get_files_cubit.dart';

@freezed
class GetFilesState with _$GetFilesState {
  const factory GetFilesState.initial() = _Initial;
  const factory GetFilesState.loading() = _Loading;
  const factory GetFilesState.success({required List<FileManagerModel> files}) = _Success;
  const factory GetFilesState.error({required String error}) = _Error;
}
