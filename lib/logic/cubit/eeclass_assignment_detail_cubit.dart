import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/utilties/ColorfulPrintFunction.dart';
import 'package:equatable/equatable.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';

part 'eeclass_assignment_detail_state.dart';

class EeclassAssignmentDetailCubit extends Cubit<EeclassAssignmentDetailState> {
  EeclassAssignmentDetailCubit({required this.eeclassRepository})
      : super(EeclassAssignmentDetailState());
  final EeclassRepository eeclassRepository;

  Future<void> onOpenPopupAssignmentCardRequest({
    required String assignmentUrl,
  }) async {
    emit(state.copyWith(
        detailCardStatus: EeclassAssignmentDetailCardStatus.loading));
    try {
      final assignmentInfo =
          await eeclassRepository.getAssignment(url: assignmentUrl);
      emit(state.copyWith(
          detailCardStatus: EeclassAssignmentDetailCardStatus.success,
          assignmentCardData: assignmentInfo));
    } catch (e, stacktrace) {
      print(e);
      printHighlight(stacktrace);
      if (!isClosed) {
        emit(state.copyWith(
            detailCardStatus: EeclassAssignmentDetailCardStatus.failed));
      }
    }
  }
}
