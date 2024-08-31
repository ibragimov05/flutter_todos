import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

import '../../edit_todo/view/edit_todo_page.dart';
import '../bloc/todos_overview_bloc.dart';
import '../widgets/widgets.dart';

class TodosOverviewPage extends StatelessWidget {
  const TodosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosOverviewBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(const TodosOverviewSubscriptionRequested()),
      child: const TodosOverviewView(),
    );
  }
}

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final todoBloc = context.read<TodosOverviewBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todosOverviewAppBarTitle),
        actions: [
          TodosOverviewFilterButton(),
          TodosOverviewOptionsButton(),
          TodosOverviewLogoutButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, todoState) {
              if (todoState.status == TodosOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.todosOverviewErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTodo != current.lastDeletedTodo &&
                current.lastDeletedTodo != null,
            listener: (context, todoState) {
              final deletedTodo = todoState.lastDeletedTodo!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      l10n.todosOverviewTodoDeletedSnackbarText(
                        deletedTodo.title,
                      ),
                    ),
                    action: SnackBarAction(
                      label: l10n.todosOverviewUndoDeletionButtonText,
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        todoBloc
                            .add(const TodosOverviewUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
          builder: (context, todoState) {
            if (todoState.todos.isEmpty) {
              if (todoState.status == TodosOverviewStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (todoState.status != TodosOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    l10n.todosOverviewEmptyText,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }
            return CupertinoScrollbar(
              child: ListView.builder(
                itemCount: todoState.todos.length,
                itemBuilder: (context, index) {
                  final todo = todoState.todos[index];
                  return TodoListTile(
                    todo: todo,
                    onToggleCompleted: (isCompleted) => todoBloc.add(
                      TodosOverviewTodoCompletionToggled(
                                todo: todo,
                                isCompleted: isCompleted,
                              ),
                            ),
                    onDismissed: (_) {
                      todoBloc.state.todos.removeWhere(
                        (element) => element.id == todo.id,
                      );
                      todoBloc.add(
                        TodosOverviewTodoDeleted(todo: todo),
                      );
                    },
                    onTap: () => Navigator.of(context).push(
                      EditTodoPage.route(initialTodo: todo),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
