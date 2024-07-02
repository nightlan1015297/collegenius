import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/models/error_model/ErrorModel.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:collegenius/repositories/course_schedual_repository.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/repositories/portal_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.g.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.eeclassRepository,
    required this.courseSchedualRepository,
    required this.portalRepository,
  }) : super(const AuthenticationState()) {
    on<CourseSelectAuthenticateRequest>(_onCourseSelectAuthenticateRequest);
    on<PortalCaptchaAcquiredRequest>(_onPortalCaptchaAcquiredRequest);
    on<EeclassAuthenticateRequest>(_onEeclassAuthenticateRequest);
    on<AuthenticationLogoutRequest>(_onAuthenticationLogoutRequest);
    on<InitializeRequest>(_onInitializeRequest);
    on<PortalAuthenticateRequest>(_onPortalAuthenticateRequest);
  }
  final EeclassRepository eeclassRepository;
  final CourseSchedualRepository courseSchedualRepository;
  final PortalRepository portalRepository;

  void _onInitializeRequest(
    InitializeRequest event,
    Emitter<AuthenticationState> emit,
  ) async {
    /// Check if the user is logged in to the Course Select system
    /// if they are, then we will try to validate the account again
    /// to see whether the account is still valid since the user may have
    /// changed their password or whatever.
    if (!state.courseSelectAuthStatus.isUnauth) {
      add(CourseSelectAuthenticateRequest(user: state.courseSelectUserData));
    }
    if (!state.eeclassAuthStatus.isUnauth) {
      add(EeclassAuthenticateRequest(user: state.eeclassUserData));
    }
    //! Portal related Service
    // if (state.portalAuthStatus.isAuthed) {
    //   add(PortalAuthenticateRequest(user: state.portalUserData));
    // }
  }

  void _onPortalCaptchaAcquiredRequest(
    PortalCaptchaAcquiredRequest event,
    Emitter<AuthenticationState> emit,
  ) async {
    final cookies = event.cookies;
    for (var cookie in cookies) {
      portalRepository.setCookie(cookie: cookie);
    }
    final needCaptcha = await portalRepository.needCaptcha();
    if (needCaptcha) {
      emit(state.copyWith(portalAuthStatus: PortalAuthStatus.needCaptcha));
    } else {
      if (state.portalUserData.isEmpty) {
        emit(state.copyWith(portalAuthStatus: PortalAuthStatus.unauth));
      } else {
        final user = state.portalUserData;
        emit(state.copyWith(portalAuthStatus: PortalAuthStatus.loading));

        final validateResult = await portalRepository.login(
          username_: user.id,
          password_: user.password,
        );
        if (validateResult) {
          emit(
            state.copyWith(
              portalAuthStatus: PortalAuthStatus.authed,
              portalUserData: user,
            ),
          );
        } else
          emit(state.copyWith(
            portalUserData: user,
            portalAuthStatus: PortalAuthStatus.unauth,
          ));
      }
    }
  }

  void _onPortalAuthenticateRequest(
    PortalAuthenticateRequest event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(portalAuthStatus: PortalAuthStatus.loading));
    await portalRepository.initializeDio();
    final needCaptcha = await portalRepository.needCaptcha();
    if (needCaptcha) {
      emit(
        state.copyWith(
            portalAuthStatus: PortalAuthStatus.needCaptcha,
            portalUserData: event.user),
      );
    } else {
      try {
        await portalRepository.login(
          username_: event.user.id,
          password_: event.user.password,
        );
        emit(state.copyWith(
            portalAuthStatus: PortalAuthStatus.authed,
            portalUserData: event.user));
      } catch (e, stacktrace) {
        emit(
          state.copyWith(
            portalUserData: event.user,
            portalAuthStatus: PortalAuthStatus.unauth,
            portalError: ErrorModel(
              exception: e.toString(),
              stackTrace: stacktrace.toString(),
            ),
          ),
        );
      }
    }
  }

  void _onCourseSelectAuthenticateRequest(
    CourseSelectAuthenticateRequest event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(courseSelectAuthStatus: AuthStatus.loading));
    try {
      await courseSchedualRepository.login(
        username_: event.user.id,
        password_: event.user.password,
      );
      emit(
        state.copyWith(
            courseSelectAuthStatus: AuthStatus.authed,
            courseSelectUserData: event.user),
      );
    } catch (e, stacktrace) {
      emit(
        state.copyWith(
          courseSelectAuthStatus: AuthStatus.unauth,
          courseSelectUserData: event.user,
          courseSelectError: ErrorModel(
            exception: e.toString(),
            stackTrace: stacktrace.toString(),
          ),
        ),
      );
    }
  }

  void _onEeclassAuthenticateRequest(
    EeclassAuthenticateRequest event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(eeclassAuthStatus: AuthStatus.loading));
    try {
      await eeclassRepository.login(
          username_: event.user.id, password_: event.user.password);
      emit(state.copyWith(
          eeclassAuthStatus: AuthStatus.authed, eeclassUserData: event.user));
    } catch (e, stacktrace) {
      print(e);
      emit(
        state.copyWith(
          eeclassAuthStatus: AuthStatus.unauth,
          eeclassUserData: event.user,
          eeclassError: ErrorModel(
            exception: e.toString(),
            stackTrace: stacktrace.toString(),
          ),
        ),
      );
    }
  }

  void _onAuthenticationLogoutRequest(
    AuthenticationLogoutRequest event,
    Emitter<AuthenticationState> emit,
  ) async {
    eeclassRepository.logout();
    courseSchedualRepository.logout();
    //! Portal related code
    // portalRepository.logout();
    return emit(AuthenticationState());
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    return AuthenticationState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return state.toJson();
  }
}
