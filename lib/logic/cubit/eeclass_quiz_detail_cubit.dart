import 'package:bloc/bloc.dart';
import 'package:collegenius/models/eeclass_model/EeclassQuiz.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:equatable/equatable.dart';

part 'eeclass_quiz_detail_state.dart';

class EeclassQuizDetailCubit extends Cubit<EeclassQuizDetailState> {
  EeclassQuizDetailCubit({required this.eeclassRepository})
      : super(EeclassQuizDetailState());
  final EeclassRepository eeclassRepository;

  Future<void> onOpenPopupQuizCardRequest({required String quizUrl}) async {
    emit(state.copyWith(quizCardStatus: EeclassQuizDetailCardStatus.loading));
    try {
      final quizInfo = await eeclassRepository.getQuiz(url: quizUrl);
      emit(state.copyWith(
          quizCardStatus: EeclassQuizDetailCardStatus.success,
          quizCardData: quizInfo));
    } catch (e, stacktrace) {
      emit(state.copyWith(quizCardStatus: EeclassQuizDetailCardStatus.failed));
    }
  }
}
