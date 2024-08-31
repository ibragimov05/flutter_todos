// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_todos/l10n/l10n.dart';
// import 'package:flutter_todos/theme/theme.dart';
// import 'package:todos_repository/todos_repository.dart';
//
// import 'home/view/home_page.dart';
//
// class App extends StatelessWidget {
//   final TodosRepository todosRepository;
//
//   const App({super.key, required this.todosRepository});
//
//   @override
//   Widget build(BuildContext context) => RepositoryProvider.value(
//         value: todosRepository,
//         child: const AppView(),
//       );
// }
//
// class AppView extends StatelessWidget {
//   const AppView();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: FlutterTodosTheme.light,
//       darkTheme: FlutterTodosTheme.dark,
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//       supportedLocales: AppLocalizations.supportedLocales,
//       home: const HomePage(),
//     );
//   }
// }

import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';

import 'app/app_bloc_observer.dart';

void bootstrap(
    {required TodosApi todosApi,
    required AuthenticationRepository authenticationRepository}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };

  Bloc.observer = const AppBlocObserver();

  final todosRepository = TodosRepository(todosApi: todosApi);

  runApp(
    App(
      authenticationRepository: authenticationRepository,
      todosRepository: todosRepository,
    ),
  );
}
