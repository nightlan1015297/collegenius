import 'package:collegenius/models/error_model/ErrorModel.dart';

import 'package:collegenius/models/eeclass_model/EeclassModel.dart';

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

class EeclassBullitinsPageArguments {
  EeclassBullitinsPageArguments({
    required this.courseSerial,
  });
  final String courseSerial;
}

class EeclassBulliitinsPopupArguments {
  EeclassBulliitinsPopupArguments({
    required this.bullitinBrief,
  });
  final EeclassBullitinBrief bullitinBrief;
}

class LoginFailedArguments {
  LoginFailedArguments({required this.err});
  final ErrorModel err;
}
