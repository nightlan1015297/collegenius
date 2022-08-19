import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/models/event_model/SchoolEventModel.dart';
import 'package:collegenius/repositories/school_events_repository.dart';
import 'package:equatable/equatable.dart';

part 'school_events_state.dart';

class SchoolEventsCubit extends Cubit<SchoolEventsState> {
  SchoolEventsCubit({required this.schoolEventsRepository})
      : super(SchoolEventsState());

  final SchoolEventsRepository schoolEventsRepository;

  Future<void> fetchInitEvents() async {
    emit(state.copyWith(status: SchoolEventsStatus.loading));
    try {
      var fetchedList = await schoolEventsRepository.getEvents(1);
      emit(state.copyWith(
          status: SchoolEventsStatus.success,
          events: fetchedList.map((e) => SchoolEvent.fromJson(e)).toList(),
          loadedPage: 1));
    } catch (error) {
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
        emit(state.copyWith(status: SchoolEventsStatus.loadedend));
      } else {
        emit(state.copyWith(
            status: SchoolEventsStatus.success,
            events: state.events + fetchedList,
            loadedPage: state.loadedPage + 1));
      }
    } catch (error) {
      emit(state.copyWith(status: SchoolEventsStatus.failure));
    }
  }
}
