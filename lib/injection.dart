
import 'package:flutter_file_manager/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


final GetIt getIt = GetIt.instance;
@InjectableInit(
  initializerName: 'init',
)
Future<void> configureDependencies() async { 
  getIt.init();
}
