import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';
import 'package:tiki/respositories/mainauth.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  void ageChanged(String value) {
    emit(state.copyWith(age: value, status: SignupStatus.initial));
  }

  void usernamechanged(String value) {
    emit(state.copyWith(username: value, status: SignupStatus.initial));
  }

  void genderChanged(String value) {
    emit(state.copyWith(gender: value, status: SignupStatus.initial));
  }

  void biochange(String value) {
    emit(state.copyWith(bio: value, status: SignupStatus.initial));
  }

  void interestSelected(List value) {
    emit(state.copyWith(interest: value, status: SignupStatus.initial));
  }

  void locatioChanged(String location) {
    emit(state.copyWith(location: location, status: SignupStatus.initial));
  }

  void signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignupStatus.submitting) return;
    emit(
      state.copyWith(status: SignupStatus.submitting),
    );
    try {
      await _authRepository
          .signUp(email: state.email, password: state.password)
          .then((value) {
        _authRepository.saveUser(
          email: state.email,
          password: state.password,
          username: state.username,
        );
      });
      emit(
        state.copyWith(status: SignupStatus.success),
      );
    } catch (_) {}
  }

  void updateDatabase() async {
    try {
      await _authRepository.updateUser(
        age: state.age,
        gender: state.gender,
      );
    } catch (_) {}
  }

  void updateBio() async {
    try {
      await _authRepository.updateBio(
        bio: state.bio,
        interest: state.interest,
      );
    } catch (e) {}
  }

  void updateLocation() async {
    try {
      await _authRepository.updateLocation(
        location: state.location,
        geoPoint: const GeoPoint(0.0, 0.0),
      );
    } catch (e) {}
  }
}
