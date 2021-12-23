import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'coursesection_state.dart';

class CoursesectionCubit extends Cubit<CourseSectionState> {
  final Stream timeStream;
  late StreamSubscription timeStreamSubscribtion;

  CoursesectionCubit({required this.timeStream})
      : super(CourseSectionLoading()) {
    timeStreamSubscribtion = timeStream.listen(mapEventToState);
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

  void emitCourseSection(int section) =>
      emit(CourseSectionLoaded(section: section));

  @override
  Future<void> close() {
    timeStreamSubscribtion.cancel();
    return super.close();
  }
}
