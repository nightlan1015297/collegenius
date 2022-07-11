import 'package:bloc/bloc.dart';
import 'package:collegenius/models/event_model/event_model.dart';
import 'package:collegenius/repositories/school_events_repository.dart';
import 'package:equatable/equatable.dart';

part 'school_events_state.dart';

class SchoolEventsCubit extends Cubit<SchoolEventsState> {
  SchoolEventsCubit(
    this._courseSchedualRepository,
  ) : super(SchoolEventsState());

  final SchoolEventsRepository _courseSchedualRepository;

  Future<void> fetchInitEvents() async {
    emit(state.copywith(status: SchoolEventsStatus.loading));
    try {
      var fetchedList = await _courseSchedualRepository.getEvents(1);
      emit(state.copywith(
          status: SchoolEventsStatus.success,
          events: fetchedList.map((e) => Event.fromJson(e)).toList(),
          loadedPage: 1));
    } catch (error) {
      emit(state.copywith(status: SchoolEventsStatus.failure));
    }
  }

  Future<void> fetchMoreEvents() async {
    try {
      var fetched =
          await _courseSchedualRepository.getEvents(state.loadedPage + 1);
      var fetchedList = fetched.map((e) => Event.fromJson(e)).toList();

      if (fetchedList.last == state.events.last) {
        emit(state.copywith(status: SchoolEventsStatus.loadedend));
      } else {
        emit(state.copywith(
            status: SchoolEventsStatus.success,
            events: state.events + fetchedList,
            loadedPage: state.loadedPage + 1));
      }
    } catch (error) {
      emit(state.copywith(status: SchoolEventsStatus.failure));
    }
  }
}
