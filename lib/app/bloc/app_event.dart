part of 'app_bloc.dart';

@immutable
sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

final class _AppUserChanged extends AppEvent {
  final User user;

  const _AppUserChanged(this.user);
}
