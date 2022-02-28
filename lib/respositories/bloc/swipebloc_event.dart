part of 'swipebloc_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object> get props => [];
}

class LoadedSwipe extends SwipeEvent {}

class LoadUsersEvent extends SwipeEvent {
  final List<User> users;

  const LoadUsersEvent(
    this.users,
  );

  @override
  List<Object> get props => [users];
}

class SwipeLeftEvent extends SwipeEvent {
  final User user;

  const SwipeLeftEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class SwipeRightEvent extends SwipeEvent {
  final User user;

  const SwipeRightEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
