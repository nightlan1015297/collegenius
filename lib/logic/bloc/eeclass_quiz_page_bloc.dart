import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:equatable/equatable.dart';

part 'eeclass_quiz_page_event.dart';
part 'eeclass_quiz_page_state.dart';

class EeclassQuizPageBloc
    extends Bloc<EeclassQuizPageEvent, EeclassQuizPageState> {
  EeclassQuizPageBloc({
    required this.authenticateBloc,
    required this.eeclassRepository,
    required this.courseSerial,
  }) : super(EeclassQuizPageState()) {
    on<InitializeRequest>(_onInitializeRequest);
    on<FetchOverViewDataRequest>(_onFetchOverViewDataRequest);

    authenticateBlocSubscription = authenticateBloc.stream.listen((event) {
      onAuthenticateStatechanged(event);
    });
  }
  final String courseSerial;
  final EeclassRepository eeclassRepository;
  final AuthenticationBloc authenticateBloc;
  late StreamSubscription<AuthenticationState> authenticateBlocSubscription;

  void onAuthenticateStatechanged(AuthenticationState event) {
    add(InitializeRequest());
  }

  void _onInitializeRequest(
    InitializeRequest event,
    Emitter<EeclassQuizPageState> emit,
  ) {
    switch (authenticateBloc.state.eeclassAuthenticated) {
      case true:
        add(FetchOverViewDataRequest());
        break;
      case false:
        emit(state.copyWith(
            overviewStatus: EeclassQuizPageOverviewStatus.unauthenticate));
        break;
    }
  }

  Future<void> _onFetchOverViewDataRequest(
    FetchOverViewDataRequest event,
    Emitter<EeclassQuizPageState> emit,
  ) async {
    emit(EeclassQuizPageState(
      overviewStatus: EeclassQuizPageOverviewStatus.loading,
    ));
    final user = authenticateBloc.state.eeclassUserData;

    await eeclassRepository.login(username_: user.id, password_: user.password);

    final courseQuiz =
        await eeclassRepository.getCourseQuiz(courseSerial: this.courseSerial);

    if (courseQuiz.isNotEmpty) {
      emit(state.copyWith(
          quizList: courseQuiz,
          overviewStatus: EeclassQuizPageOverviewStatus.success));
    } else {
      emit(state.copyWith(
          quizList: courseQuiz,
          overviewStatus: EeclassQuizPageOverviewStatus.noquiz));
    }
  }

  @override
  Future<void> close() async {
    authenticateBlocSubscription.cancel();
    await super.close();
  }
}
