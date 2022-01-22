import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collegenius/utilties/ticker.dart';
import 'package:equatable/equatable.dart';

part 'course_section_state.dart';

class CoursesectionCubit extends Cubit<CourseSectionState> {
  final Ticker ticker;
  late StreamSubscription<int> _tickerSubscription;

  CoursesectionCubit({required this.ticker}) : super(CourseSectionState()) {
    _tickerSubscription = ticker.tick(1).listen((event) {
      mapEventToState(DateTime.now());
    });
  }

  void mapEventToState(event) {
    if (event.isBefore(DateTime(event.year, event.month, event.day, 8))) {
      emitCourseSection(-1);
    } else if (event.isAfter(DateTime(event.year, event.month, event.day, 8)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 8, 50))) {
      emitCourseSection(0);
    } else if (event.isAfter(DateTime(event.year, event.month, event.day, 9)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 9, 50))) {
      emitCourseSection(1);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 10)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 10, 50))) {
      emitCourseSection(2);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 11)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 11, 50))) {
      emitCourseSection(3);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 12)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 12, 50))) {
      emitCourseSection(4);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 13)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 13, 50))) {
      emitCourseSection(5);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 14)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 14, 50))) {
      emitCourseSection(6);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 15)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 15, 50))) {
      emitCourseSection(7);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 16)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 16, 50))) {
      emitCourseSection(8);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 17)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 17, 50))) {
      emitCourseSection(9);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 18)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 18, 50))) {
      emitCourseSection(10);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 19)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 19, 50))) {
      emitCourseSection(11);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 20)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 20, 50))) {
      emitCourseSection(12);
    } else if (event
            .isAfter(DateTime(event.year, event.month, event.day, 21)) &&
        event.isBefore(DateTime(event.year, event.month, event.day, 21, 50))) {
      emitCourseSection(13);
    } else if (event
        .isAfter(DateTime(event.year, event.month, event.day, 21, 50))) {
      emitCourseSection(14);
    }
  }

  void emitCourseSection(int section) => emit(state.copywith(
      status: CourseSectionStatus.success, cerrentSection: section));

  void changeSelectedSemester(String semester) =>
      emit(state.copywith(choosenSemester: semester));

  void changeSelectedDays(int days) => emit(state.copywith(choosenDays: days));
  @override
  Future<void> close() {
    _tickerSubscription.cancel();
    return super.close();
  }
}
