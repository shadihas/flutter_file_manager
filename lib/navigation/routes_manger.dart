import 'package:flutter/cupertino.dart';
import 'package:flutter_file_manager/feature/home/presentation/pages/sub_folder_page.dart';
import 'package:go_router/go_router.dart';
import '../feature/home/presentation/pages/home_page.dart';
import 'app_routes_names.dart';

class RoutesManager {
  late final GoRouter _appRouter;
  GoRouter get router => _appRouter;
  RoutesManager() {
    _appRouter = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: AppRoutesNames.home,
          pageBuilder: (context, state) => CupertinoPage(
            child: const HomePage(),
            key: state.pageKey,
            name: state.name,
          ),
        ),
        GoRoute(
            path: '/subFolder',
            name: AppRoutesNames.subFolder,
            pageBuilder: (context, state) {
              final Object args = state.extra!;
              final String fileName = args as String;
              return CupertinoPage(
                child: SubFolderPage(fileName: fileName),
                key: state.pageKey,
                name: state.name,
              );
            })
      ],
    );
  }
}
