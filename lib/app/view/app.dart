import 'package:flutter/material.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

import '../bloc/app_bloc.dart';
import '../routes/routes.dart';
import '../../theme/theme.dart';

class App extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;
  final TodosRepository _todosRepository;

  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
    required TodosRepository todosRepository,
  })  : _authenticationRepository = authenticationRepository,
        _todosRepository = todosRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _todosRepository),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterTodosTheme.light,
      darkTheme: FlutterTodosTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FlowBuilder<AppStatus>(
        state: context.select(
          (AppBloc bloc) => bloc.state.status,
        ),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
