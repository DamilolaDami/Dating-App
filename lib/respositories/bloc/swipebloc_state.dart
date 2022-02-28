part of 'swipebloc_bloc.dart';

abstract class SwipeState extends Equatable {
  const SwipeState();

  @override
  List<Object> get props => [];
}

class SwipeLoading extends SwipeState {}

class SwipeLoaded extends SwipeState {
  final List<User> users;

  const SwipeLoaded({
    this.users = const <User>[],
  });

  @override
  List<Object> get props => [users];
}

class SwipeError extends SwipeState {}

class SwipeEmpty extends SwipeState {
  final String message;

  const SwipeEmpty({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
