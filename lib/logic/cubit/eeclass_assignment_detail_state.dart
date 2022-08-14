part of 'eeclass_assignment_detail_cubit.dart';

enum EeclassAssignmentDetailCardStatus {
  loading,
  success,
  failed,
}

class EeclassAssignmentDetailState extends Equatable {
  const EeclassAssignmentDetailState(
      {EeclassAssignmentDetailCardStatus? detailCardStatus,
      EeclassAssignment? assignmentCardData})
      : detailCardStatus =
            detailCardStatus ?? EeclassAssignmentDetailCardStatus.loading,
        assignmentCardData = assignmentCardData;

  final EeclassAssignmentDetailCardStatus detailCardStatus;
  final EeclassAssignment? assignmentCardData;

  EeclassAssignmentDetailState copyWith(
      {EeclassAssignmentDetailCardStatus? detailCardStatus,
      EeclassAssignment? assignmentCardData}) {
    return EeclassAssignmentDetailState(
      detailCardStatus: detailCardStatus ?? this.detailCardStatus,
      assignmentCardData: assignmentCardData ?? this.assignmentCardData,
    );
  }

  @override
  List<Object?> get props => [detailCardStatus, assignmentCardData];
}
