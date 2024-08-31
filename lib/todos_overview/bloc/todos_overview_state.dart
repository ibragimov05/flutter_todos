part of 'todos_overview_bloc.dart';

enum TodosOverviewStatus { initial, loading, success, failure }

final class TodosOverviewState extends Equatable {
  final TodosOverviewStatus status;
  final List<Todo> todos;
  final TodosViewFilter filter;
  final Todo? lastDeletedTodo;

  const TodosOverviewState({
    this.status = TodosOverviewStatus.initial,
    this.todos = const [],
    this.filter = TodosViewFilter.all,
    this.lastDeletedTodo,
  });

  Iterable<Todo> get filteredTodos => filter.applyAll(todos);

  TodosOverviewState copyWith({
    TodosOverviewStatus Function()? status,
    List<Todo> Function()? todos,
    TodosViewFilter Function()? filter,
    Todo? Function()? lastDeletedTodo,
  }) =>
      TodosOverviewState(
        status: status != null ? status() : this.status,
        todos: todos != null ? todos() : this.todos,
        filter: filter != null ? filter() : this.filter,
        lastDeletedTodo:
            lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
      );

  @override
  List<Object?> get props => [status, todos, filter, lastDeletedTodo];
}
