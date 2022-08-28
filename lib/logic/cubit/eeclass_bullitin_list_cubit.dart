import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:collegenius/models/eeclass_model/EeclassBullitinBrief.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

part 'eeclass_bullitin_list_state.dart';

class EeclassBullitinListCubit extends Cubit<EeclassBullitinListState> {
  EeclassBullitinListCubit({
    required this.courseSerial,
    required this.eeclassRepository,
  }) : super(EeclassBullitinListState());

  final String courseSerial;
  final EeclassRepository eeclassRepository;

  Future<void> fetchInitBullitin() async {
    if (!isClosed) {
      emit(state.copyWith(status: EeclassBullitinListStatus.loading));
    }
    try {
      var fetchedList = await eeclassRepository.getCourseBulletin(
        courseSerial: courseSerial,
        page: 1,
      );
      if (!isClosed) {
        emit(
          state.copyWith(
              status: EeclassBullitinListStatus.success,
              bullitins: fetchedList,
              loadedPage: 1),
        );
      }
    } catch (e, stacktrace) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      final _crashInstance = FirebaseCrashlytics.instance;
      _crashInstance.setCustomKey("Error on", "Eeclass_bullitins_list");
      _crashInstance.setCustomKey("Initial fetch", true);
      _crashInstance.setCustomKey("Catch on", "Fetching data");
      _crashInstance.setCustomKey("Connection type", connectivityResult.name);
      _crashInstance.recordError(e, stacktrace);
      if (!isClosed) {
        emit(state.copyWith(status: EeclassBullitinListStatus.failure));
      }
    }
  }

  Future<void> fetchMoreBullitin() async {
    try {
      var newFetched = await eeclassRepository.getCourseBulletin(
        courseSerial: courseSerial,
        page: state.loadedPage + 1,
      );
      if (newFetched.isEmpty) {
        if (!isClosed) {
          emit(state.copyWith(isLoadedEnd: true));
        }
      } else {
        if (!isClosed) {
          emit(state.copyWith(
              status: EeclassBullitinListStatus.success,
              bullitins: state.bullitins + newFetched,
              loadedPage: state.loadedPage + 1));
        }
      }
    } catch (e, stacktrace) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      final _crashInstance = FirebaseCrashlytics.instance;
      _crashInstance.setCustomKey("Error on", "Eeclass_bullitins_list");
      _crashInstance.setCustomKey("Initial fetch", false);
      _crashInstance.setCustomKey("Catch on", "Fetching data");
      _crashInstance.setCustomKey("Connection type", connectivityResult.name);
      _crashInstance.recordError(e, stacktrace);
      if (!isClosed) {
        emit(state.copyWith(status: EeclassBullitinListStatus.failure));
      }
    }
  }
}
