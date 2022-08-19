import 'package:bloc/bloc.dart';
import 'package:collegenius/utilties/ColorfulPrintFunction.dart';
import 'package:equatable/equatable.dart';

import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';

part 'eeclass_bullitin_detail_state.dart';

class EeclassBullitinDetailCubit extends Cubit<EeclassBullitinDetailState> {
  EeclassBullitinDetailCubit({
    required this.eeclassRepository,
  }) : super(EeclassBullitinDetailState());
  final EeclassRepository eeclassRepository;

  Future<void> onOpenPopupBullitinCardRequest({
    required String bullitinUrl,
  }) async {
    emit(state.copyWith(
        detailCardStatus: EeclassBullitinDetailCardStatus.loading));
    try {
      final bullitinInfo =
          await eeclassRepository.getBullitin(url: bullitinUrl);
      emit(state.copyWith(
          detailCardStatus: EeclassBullitinDetailCardStatus.success,
          bullitinCardData: bullitinInfo));
    } catch (e, stacktrace) {
      print(e);
      printHighlight(stacktrace);
      if (!isClosed) {
        emit(state.copyWith(
            detailCardStatus: EeclassBullitinDetailCardStatus.failed));
      }
    }
  }
}
