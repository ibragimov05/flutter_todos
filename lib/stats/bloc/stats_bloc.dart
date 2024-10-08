import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos_repository/todos_repository.dart';

part 'stats_event.dart';

part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosRepository _todosRepository;

  StatsBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const StatsState()) {
    on<StatsSubscriptionRequested>(_onStatsSubscriptionRequested);
  }

  Future<void> _onStatsSubscriptionRequested(
    StatsSubscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));

    final userID = FirebaseAuth.instance.currentUser?.uid ?? '';

    await emit.forEach<List<Todo>>(
      _todosRepository.getTodos(userId: userID),
      onData: (todos) => state.copyWith(
        status: StatsStatus.success,
        completedTodos: todos.where((todo) => todo.isCompleted).length,
        activeTodos: todos.where((todo) => !todo.isCompleted).length,
      ),
      onError: (_, __) => state.copyWith(status: StatsStatus.failure),
    );
  }
}
