// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apptheme_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppthemeState _$AppthemeStateFromJson(Map<String, dynamic> json) =>
    AppthemeState(
      themeMode: $enumDecode(_$ThemeModeEnumMap, json['themeMode']),
    );

Map<String, dynamic> _$AppthemeStateToJson(AppthemeState instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
