import 'package:app/data/model/user_model.dart';

sealed class UserState {}


// initial
final class UserInitialState extends UserState {}

// loading
final class UserLoadingState extends UserState {}


// success
final class UserSucessState extends UserState {

  final UserModel userModel;

  // on success we pass the data from the repository which is fetched from provider
  UserSucessState({required this.userModel});
}

final class UserErrorState extends UserState {
  final String error;

  UserErrorState({required this.error});
}

