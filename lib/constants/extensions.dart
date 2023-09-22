import 'package:flutter/material.dart';

import 'enums.dart';

extension CoursepageStatusX on AuthStatus {
  bool get isLoading => this == AuthStatus.loading;
  bool get isAuthed => this == AuthStatus.authed;
  bool get isUnauth => this == AuthStatus.unauth;
}

extension SchoolEventsStatusX on SchoolEventsStatus {
  bool get isInitial => this == SchoolEventsStatus.initial;
  bool get isLoading => this == SchoolEventsStatus.loading;
  bool get isLoadmore => this == SchoolEventsStatus.loadedend;
  bool get isSuccess => this == SchoolEventsStatus.success;
  bool get isFailure => this == SchoolEventsStatus.failure;
}

extension LanguageX on Language {
  bool get isEn => this == Language.en;
  bool get isZh => this == Language.zh;
}

extension PortalAuthStatusX on PortalAuthStatus {
  bool get isLoading => this == PortalAuthStatus.loading;
  bool get isAuthed => this == PortalAuthStatus.authed;
  bool get isUnauth => this == PortalAuthStatus.unauth;
  bool get isNeedCaptcha => this == PortalAuthStatus.needCaptcha;
}

extension ThemeModeX on ThemeMode {
  bool get isLight => this == ThemeMode.light;
  bool get isDark => this == ThemeMode.dark;
  bool get isSystem => this == ThemeMode.system;
}

extension VerifyStatusX on VerifyStatus {
  bool get isValid => this == VerifyStatus.valid;
  bool get isInvalid => this == VerifyStatus.invalid;
  bool get isEmpty => this == VerifyStatus.empty;
}