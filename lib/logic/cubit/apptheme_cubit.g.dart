// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apptheme_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppthemeState _$AppthemeStateFromJson(Map<String, dynamic> json) =>
    AppthemeState(
      themeOption: $enumDecode(_$AppthemeOptionEnumMap, json['themeOption']),
    );

Map<String, dynamic> _$AppthemeStateToJson(AppthemeState instance) =>
    <String, dynamic>{
      'themeOption': _$AppthemeOptionEnumMap[instance.themeOption]!,
    };

const _$AppthemeOptionEnumMap = {
  AppthemeOption.dark: 'dark',
  AppthemeOption.light: 'light',
  AppthemeOption.system: 'system',
};
