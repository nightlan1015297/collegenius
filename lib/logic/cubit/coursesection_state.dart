part of 'coursesection_cubit.dart';

abstract class CourseSectionState extends Equatable {
  const CourseSectionState();

  @override
  List<Object> get props => [];
}

class CourseSectionLoading extends CourseSectionState {}

class CourseSectionLoaded extends CourseSectionState {
  CourseSectionLoaded({
    required this.section,
  });
  final int section;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseSectionLoaded && other.section == section;
  }

  @override
  int get hashCode => section.hashCode;
}
