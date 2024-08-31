import 'models/todo.dart';

abstract class TodosApi {
  const TodosApi();

  /// Provides s [Stream] of all todos.
  Stream<List<Todo>> getTodos({required String userId});

  /// Saves a [todo].
  Future<void> saveTodo({required Todo todo});

  /// Edits a [Todo]
  Future<void> editTodo({required Todo todo});

  /// Deletes a `todo` with the given id
  ///
  /// if no `todo` with the given id exists, a [TodoNotFoundException] error is thrown
  Future<void> deleteTodo({required String id});

  /// Deletes all completed todos.
  ///
  /// Returns the number of deleted todos.
  Future<int> clearCompleted();

  /// Sets the `isCompleted` state of all todos to the given value
  ///
  /// Returns the number of updated todos.
  Future<int> completeAll({required bool isCompleted});
}

/// Error thrown when a [Todo] with the given id is not found.
class TodoNotFoundException implements Exception {}
