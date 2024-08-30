import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todos_overview_event.dart';
part 'todos_overview_state.dart';

class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
  TodosOverviewBloc() : super(TodosOverviewInitial()) {
    on<TodosOverviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
