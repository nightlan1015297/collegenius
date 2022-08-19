part of 'app_setting_bloc.dart';

abstract class AppSettingEvent extends Equatable {
  const AppSettingEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeRequest extends AppSettingEvent {
  const ChangeThemeRequest({required this.themeMode});
  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

class ChangeLocalizeRequest extends AppSettingEvent {
  const ChangeLocalizeRequest({required this.locale});
  final Locale locale;

  @override
  List<Object> get props => [locale];
}
