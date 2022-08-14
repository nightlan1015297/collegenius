import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:flutter/cupertino.dart';

class EeclassCourseArguments {
  EeclassCourseArguments({required this.courseSerial});
  final String courseSerial;
}

class EeclassPopupInfoArguments {
  EeclassPopupInfoArguments({required this.courseInfo});
  final EeclassCourseInformation courseInfo;
}

class EeclassQuizzesPageArguments {
  EeclassQuizzesPageArguments({required this.quizList});
  final List<EeclassQuizBrief> quizList;
}

class EeclassQuizzPopupArguments {
  EeclassQuizzPopupArguments({required this.quizUrl});
  final String quizUrl;
}

class EeclassMaterialsPageArguments {
  EeclassMaterialsPageArguments({required this.materialList});
  final List<EeclassMaterialBrief> materialList;
}

class EeclassAssignmentsPageArguments {
  EeclassAssignmentsPageArguments({required this.assignmentList});
  final List<EeclassAssignmentBrief> assignmentList;
}

class EeclassAssignmentsPopupArguments {
  EeclassAssignmentsPopupArguments({
    required this.assignmentBrief,
  });

  final EeclassAssignmentBrief assignmentBrief;
}
