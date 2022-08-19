part of 'app_setting_bloc.dart';

@JsonSerializable()
class AppSettingState extends Equatable {
  AppSettingState({
    Language? appLanguage,
    ThemeMode? themeMode,
  })  : themeMode = themeMode ?? ThemeMode.system,
        appLanguage = appLanguage ?? Language.zh,
        super();
  final Language appLanguage;
  final ThemeMode themeMode;

  factory AppSettingState.fromJson(Map<String, dynamic> json) =>
      _$AppSettingStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppSettingStateToJson(this);

  AppSettingState copyWith({
    Language? appLanguage,
    ThemeMode? themeMode,
  }) {
    return AppSettingState(
      themeMode: themeMode ?? this.themeMode,
      appLanguage: appLanguage ?? this.appLanguage,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        appLanguage,
      ];
}
