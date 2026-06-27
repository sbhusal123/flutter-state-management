import 'package:app/bloc/user_event.dart';
import 'package:app/bloc/user_state.dart';
import 'package:app/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserRepository _userRepository;

  UserBloc(this._userRepository): super(UserInitialState()){

    // On User Load
    on<LoadUserEvent>(
      (event, emit) async {

        emit(UserLoadingState());

        await Future.delayed(Duration(seconds: 2));
        try {
          final users = await _userRepository.getUsers();
          emit(UserSucessState(userModel: users));
        } catch (e) {
          emit(UserErrorState(error: e.toString()));
        }
      }
    );


  }
}
