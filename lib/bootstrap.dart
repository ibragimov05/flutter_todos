import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'app/app.dart';

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
