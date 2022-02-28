import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends SearchEvent {
  final String userId;

  LoadUserEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SearchInitial extends SearchEvent {}

class SelectUserEvent extends SearchEvent {
  final String currentUserId, selectedUserId, name, photoUrl;

  SelectUserEvent(
      {required this.currentUserId,
      required this.name,
      required this.photoUrl,
      required this.selectedUserId});

  @override
  List<Object> get props => [currentUserId, selectedUserId, name, photoUrl];
}

class PassUserEvent extends SearchEvent {
  final String currentUserId, selectedUserId;

  PassUserEvent(this.currentUserId, this.selectedUserId);

  @override
  List<Object> get props => [currentUserId, selectedUserId];
}
