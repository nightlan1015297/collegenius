import 'package:bloc/bloc.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    on<AuthenticatedRequested>(_onAuthenticatedRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  void _onAuthenticatedRequested(
    AuthenticatedRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit(AuthenticationState.authenticated(event.user));
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit(AuthenticationState.unauthenticated());
  }
}
