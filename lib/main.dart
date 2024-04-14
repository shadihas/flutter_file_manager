import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/resources/resources.dart';
import 'feature/home/presentation/manager/get_files_cubit/get_files_cubit.dart';
import 'injection.dart';
import 'navigation/routes_manger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await configureDependencies(); 
  runApp(FlutterFileManager());
}

class FlutterFileManager extends StatelessWidget {
  FlutterFileManager({super.key});

  final routesManager = RoutesManager();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetFilesCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) => MaterialApp.router(
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: false,
                ),
                child: child!);
          },
          debugShowCheckedModeBanner: false,
          color: Colors.white,
          theme: getApplicationThemeData(),
          routerConfig: routesManager.router,
        ),
      ),
    );
  }
}
