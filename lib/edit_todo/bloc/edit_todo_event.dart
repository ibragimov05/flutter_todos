part of 'edit_todo_bloc.dart';

sealed class EditTodoEvent extends Equatable {
  const EditTodoEvent();

  @override
  List<Object> get props => [];
}

final class EditTodoTitleChanged extends EditTodoEvent {
  final String title;

  const EditTodoTitleChanged({required this.title});

  @override
  List<Object> get props => [title];
}

final class EditTodoDescriptionChanged extends EditTodoEvent {
  final String description;

  const EditTodoDescriptionChanged({required this.description});

  @override
  List<Object> get props => [description];
}

final class EditTodoSubmitted extends EditTodoEvent {
  const EditTodoSubmitted();
}
