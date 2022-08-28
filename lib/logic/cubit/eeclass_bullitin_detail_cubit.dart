import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/enums.dart';
import 'package:collegenius/utilties/ColorfulPrintFunction.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

part 'eeclass_bullitin_detail_state.dart';

class EeclassBullitinDetailCubit extends Cubit<EeclassBullitinDetailState> {
  EeclassBullitinDetailCubit({
    required this.eeclassRepository,
  }) : super(EeclassBullitinDetailState());
  final EeclassRepository eeclassRepository;

  Future<void> onOpenPopupBullitinCardRequest({
    required String bullitinUrl,
  }) async {
    if (!isClosed) {
      emit(state.copyWith(
          detailCardStatus: EeclassBullitinDetailCardStatus.loading));
    }
    try {
      final bullitinInfo =
          await eeclassRepository.getBullitin(url: bullitinUrl);
      if (!isClosed) {
        emit(state.copyWith(
            detailCardStatus: EeclassBullitinDetailCardStatus.success,
            bullitinCardData: bullitinInfo));
      }
    } catch (e, stacktrace) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      final _crashInstance = FirebaseCrashlytics.instance;
      _crashInstance.setCustomKey("Error on", "Eeclass_bullitin_detail");
      _crashInstance.setCustomKey("Catch on", "Fetching data");
      _crashInstance.setCustomKey("Connection type", connectivityResult.name);
      _crashInstance.recordError(e, stacktrace);
      if (!isClosed) {
        emit(state.copyWith(
            detailCardStatus: EeclassBullitinDetailCardStatus.failed));
      }
    }
  }
}
