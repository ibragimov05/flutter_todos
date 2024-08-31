import 'package:flutter/widgets.dart';
import 'package:flutter_todos/bootstrap.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_todos_api/firestore_todos_api.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  final todosApi = FirestoreTodosApi();

  bootstrap(
    todosApi: todosApi,
    authenticationRepository: authenticationRepository,
  );
}
