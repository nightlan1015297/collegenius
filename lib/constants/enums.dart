enum AuthStatus {
  loading,
  authed,
  unauth,
}

enum EeclassAssignmentDetailCardStatus {
  loading,
  success,
  failed,
}

enum EeclassBullitinDetailCardStatus {
  loading,
  success,
  failed,
}

enum EeclassBullitinListStatus {
  initial,
  loading,
  success,
  failure,
}

enum EeclassCourseListStatus {
  unAuthentucated,
  initial,
  loading,
  success,
  failed,
}

enum EeclassCoursePageStatus {
  unAuthentucated,
  initial,
  loading,
  success,
  failed,
}

enum EeclassMaterialDetailCardStatus {
  loading,
  success,
  failed,
}

enum EeclassQuizDetailCardStatus {
  loading,
  success,
  failed,
}

enum EeclassQuizInfoStatus {
  loading,
  good,
  normal,
  bad,
  canNotParse,
  noQuiz,
}

enum SchoolEventsStatus {
  initial,
  loading,
  loadedend,
  success,
  failure,
}

enum Language {
  en,
  zh,
}

enum PortalAuthStatus {
  loading,
  needCaptcha,
  authed,
  unauth,
}

enum VerifyStatus {
  empty,
  valid,
  invalid,
}

enum SubmissionProgress {
  initial,
  success,
  failed,
}