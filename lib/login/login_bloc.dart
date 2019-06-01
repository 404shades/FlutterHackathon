import 'dart:async';

import 'package:flutter_hackathon/authentication/authentication.dart';
import 'package:flutter_hackathon/login/login.dart';
import 'package:flutter_hackathon/user_repositroy.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final firebaser_user = await userRepository.signInWithGoogle();

        authenticationBloc.dispatch(LoggedIn(token: firebaser_user.uid));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
