part of 'app_setting_bloc.dart';

@JsonSerializable()
class AppSettingState extends Equatable {
  AppSettingState({
    Locale? locale,
    ThemeMode? themeMode,
  })  : themeMode = themeMode ?? ThemeMode.system,
        locale = locale ?? Locale('zh', ''),
        super();
  final Locale locale;
  final ThemeMode themeMode;

  factory AppSettingState.fromJson(Map<String, dynamic> json) =>
      _$AppSettingStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppSettingStateToJson(this);

  AppSettingState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
  }) {
    return AppSettingState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        locale,
      ];
}
