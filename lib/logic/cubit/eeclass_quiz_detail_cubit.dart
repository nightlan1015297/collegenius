import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/enums.dart';
import 'package:collegenius/models/eeclass_model/EeclassQuiz.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/utilties/ColorfulPrintFunction.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

part 'eeclass_quiz_detail_state.dart';

class EeclassQuizDetailCubit extends Cubit<EeclassQuizDetailState> {
  EeclassQuizDetailCubit({required this.eeclassRepository})
      : super(EeclassQuizDetailState());
  final EeclassRepository eeclassRepository;

  Future<void> onOpenPopupQuizCardRequest({required String quizUrl}) async {
    if (!isClosed) {
      emit(state.copyWith(quizCardStatus: EeclassQuizDetailCardStatus.loading));
    }
    try {
      final quizInfo = await eeclassRepository.getQuiz(url: quizUrl);
      if (!isClosed) {
        emit(state.copyWith(
            quizCardStatus: EeclassQuizDetailCardStatus.success,
            quizCardData: quizInfo));
      }
    } catch (e, stacktrace) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      final _crashInstance = FirebaseCrashlytics.instance;
      _crashInstance.setCustomKey("Error on", "Eeclass_quiz_detail");
      _crashInstance.setCustomKey("Catch on", "Fetching data");
      _crashInstance.setCustomKey("Connection type", connectivityResult.name);
      _crashInstance.recordError(e, stacktrace);
      if (!isClosed) {
        emit(
            state.copyWith(quizCardStatus: EeclassQuizDetailCardStatus.failed));
      }
    }
  }
}
