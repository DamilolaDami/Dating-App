// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:tiki/authentications_bloc/authentication_event.dart';
// import 'package:tiki/authentications_bloc/authentication_state.dart';
// import 'package:tiki/respositories/respositories.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final Userrespository _userrespository;

//   AuthenticationBloc({required Userrespository userrespository})
//       : _userrespository = userrespository;

//   AuthenticationState get initialState => Unauthenticated();

//   @override
//   Stream<AuthenticationState> mapEventToState(
//     AuthenticationEvent event,
//   ) async* {
//     if (event is AppStarted) {
//       yield* _mapAppStartedToState();
//     } else if (event is LoggedIn) {
//       yield* _mapLoggedInToState();
//     } else if (event is LoggedOut) {
//       yield* _mapLoggedOutToState();
//     }
//   }

//   Stream<AuthenticationState> _mapAppStartedToState() async* {
//     try {
//       final isSignedIn = await _userrespository.isSIgnedIn();
//       if (isSignedIn) {
//         final uid = await _userrespository.getUser();

//         final isFirstTime = await _userrespository.isFirstTime(uid);
//         if (isFirstTime ?? true) {
//           yield AuthenticatedButNotSet(uid);
//         } else {
//           yield Authenticated(uid);
//         }
//       } else {
//         yield Unauthenticated();
//       }
//     } catch (e) {
//       yield Unauthenticated();
//     }
//   }

//   Stream<AuthenticationState> _mapLoggedInToState() async* {
//     final isFirstTime =
//         await _userrespository.isFirstTime(await _userrespository.getUser());
//     if (isFirstTime ?? true) {
//       yield AuthenticatedButNotSet(await _userrespository.getUser());
//     } else {
//       yield Authenticated(await _userrespository.getUser());
//     }
//   }

//   Stream<AuthenticationState> _mapLoggedOutToState() async* {
//     yield Unauthenticated();
//     _userrespository.signOut();
//   }
// }
