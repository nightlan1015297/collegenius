import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

part 'eeclass_assignment_detail_state.dart';

class EeclassAssignmentDetailCubit extends Cubit<EeclassAssignmentDetailState> {
  EeclassAssignmentDetailCubit({required this.eeclassRepository})
      : super(EeclassAssignmentDetailState());
  final EeclassRepository eeclassRepository;

  Future<void> onOpenPopupAssignmentCardRequest({
    required String assignmentUrl,
  }) async {
    if (!isClosed) {
      emit(state.copyWith(
          detailCardStatus: EeclassAssignmentDetailCardStatus.loading));
    }
    try {
      final assignmentInfo =
          await eeclassRepository.getAssignment(url: assignmentUrl);
      if (!isClosed) {
        emit(state.copyWith(
            detailCardStatus: EeclassAssignmentDetailCardStatus.success,
            assignmentCardData: assignmentInfo));
      }
    } catch (e, stacktrace) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      final _crashInstance = FirebaseCrashlytics.instance;
      _crashInstance.setCustomKey("Error on", "Eeclass_assignment_detail");
      _crashInstance.setCustomKey("Catch on", "Fetching data");
      _crashInstance.setCustomKey("Connection type", connectivityResult.name);
      _crashInstance.recordError(e, stacktrace);
      if (!isClosed) {
        emit(state.copyWith(
            detailCardStatus: EeclassAssignmentDetailCardStatus.failed));
      }
    }
  }
}
