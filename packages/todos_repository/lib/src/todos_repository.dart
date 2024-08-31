import 'package:todos_api/todos_api.dart';

/// {@template todos_repository}
/// A repository that handles `todo` related requests.
/// {@endtemplate}
class TodosRepository {
  final TodosApi _todosApi;

  const TodosRepository({
    required TodosApi todosApi,
  }) : _todosApi = todosApi;

  /// Provides a [Stream] of all todos.
  Stream<List<Todo>> getTodos({required String userID}) =>
      _todosApi.getTodos(userID);

  /// Saves a [todo]
  Future<void> saveTodo(Todo todo) => _todosApi.saveTodo(todo);


  /// Edits a [todo]
  Future<void> editTodo(Todo todo) => _todosApi.editTodo(todo);

  /// Deletes the `todo` with the given id.
  ///
  /// If no `todo` with the given id exists, a [TodoNotFoundException] error is thrown
  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);

  /// Deletes all completed todos
  ///
  /// Returns number of deleted todos.
  Future<int> clearCompleted() => _todosApi.clearCompleted();

  /// Sets the `isCompleted` state of all todos to the given value.
  ///
  /// Returns the number of updated todos.
  Future<int> completeAll({required bool isCompleted}) =>
      _todosApi.completeAll(isCompleted: isCompleted);
}
