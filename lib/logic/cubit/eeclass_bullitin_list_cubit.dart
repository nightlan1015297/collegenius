import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:equatable/equatable.dart';

import 'package:collegenius/models/eeclass_model/EeclassBullitinBrief.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';

part 'eeclass_bullitin_list_state.dart';

class EeclassBullitinListCubit extends Cubit<EeclassBullitinListState> {
  EeclassBullitinListCubit({
    required this.courseSerial,
    required this.eeclassRepository,
  }) : super(EeclassBullitinListState());

  final String courseSerial;
  final EeclassRepository eeclassRepository;

  Future<void> fetchInitBullitin() async {
    emit(state.copyWith(status: EeclassBullitinListStatus.loading));
    try {
      var fetchedList = await eeclassRepository.getCourseBulletin(
        courseSerial: courseSerial,
        page: 1,
      );
      emit(
        state.copyWith(
            status: EeclassBullitinListStatus.success,
            bullitins: fetchedList,
            loadedPage: 1),
      );
    } catch (error) {
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
        emit(state.copyWith(isLoadedEnd: true));
      } else {
        emit(state.copyWith(
            status: EeclassBullitinListStatus.success,
            bullitins: state.bullitins + newFetched,
            loadedPage: state.loadedPage + 1));
      }
    } catch (error, stacktrace) {
      emit(state.copyWith(status: EeclassBullitinListStatus.failure));
    }
  }
}
