part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final String age;
  final String username;
  final String gender;
  final SignupStatus status;
  final String location;
  final String bio;
  final List interest;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const SignupState({
    required this.email,
    required this.gender,
    required this.password,
    required this.age,
    required this.bio,
    required this.username,
    required this.location,
    required this.interest,
    required this.status,
  });

  factory SignupState.initial() {
    return const SignupState(
      email: '',
      gender: '',
      age: '',
      password: '',
      bio: '',
      username: '',
      location: '',
      interest: [],
      status: SignupStatus.initial,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props =>
      [email, password, status, age, gender, bio, interest, location, username];

  SignupState copyWith({
    String? email,
    String? password,
    SignupStatus? status,
    String? age,
    String? gender,
    String? bio,
    String? username,
    List? interest,
    String? location,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      username: username ?? this.username,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      interest: interest ?? this.interest,
      age: age ?? this.age,
    );
  }
}
