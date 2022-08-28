import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/models/event_model/SchoolEventModel.dart';
import 'package:collegenius/repositories/school_events_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

part 'school_events_state.dart';

class SchoolEventsCubit extends Cubit<SchoolEventsState> {
  SchoolEventsCubit({required this.schoolEventsRepository})
      : super(SchoolEventsState());

  final SchoolEventsRepository schoolEventsRepository;

  Future<void> fetchInitEvents() async {
    if (!isClosed) {
      emit(state.copyWith(status: SchoolEventsStatus.loading));
    }
    try {
      var fetchedList = await schoolEventsRepository.getEvents(1);
      if (!isClosed) {
        emit(state.copyWith(
            status: SchoolEventsStatus.success,
            events: fetchedList.map((e) => SchoolEvent.fromJson(e)).toList(),
            loadedPage: 1));
      }
    } catch (e, stacktrace) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      final _crashInstance = FirebaseCrashlytics.instance;
      _crashInstance.setCustomKey("Error on", "School_events_list");
      _crashInstance.setCustomKey("Initial fetch", true);
      _crashInstance.setCustomKey("Catch on", "Fetching data");
      _crashInstance.setCustomKey("Connection type", connectivityResult.name);
      _crashInstance.recordError(e, stacktrace);
      if (!isClosed) {
        emit(state.copyWith(status: SchoolEventsStatus.failure));
      }
    }
  }

  Future<void> fetchMoreEvents() async {
    try {
      var fetched =
          await schoolEventsRepository.getEvents(state.loadedPage + 1);
      var fetchedList = fetched.map((e) => SchoolEvent.fromJson(e)).toList();
      if (fetchedList.last == state.events.last) {
        if (!isClosed) {
          emit(state.copyWith(status: SchoolEventsStatus.loadedend));
        }
      } else {
        if (!isClosed) {
          emit(state.copyWith(
              status: SchoolEventsStatus.success,
              events: state.events + fetchedList,
              loadedPage: state.loadedPage + 1));
        }
      }
    } catch (e, stacktrace) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      final _crashInstance = FirebaseCrashlytics.instance;
      _crashInstance.setCustomKey("Error on", "School_events_list");
      _crashInstance.setCustomKey("Initial fetch", false);
      _crashInstance.setCustomKey("Catch on", "Fetching data");
      _crashInstance.setCustomKey("Connection type", connectivityResult.name);
      _crashInstance.recordError(e, stacktrace);
      if (!isClosed) {
        emit(state.copyWith(status: SchoolEventsStatus.failure));
      }
    }
  }
}
