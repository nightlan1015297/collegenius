// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationState _$AuthenticationStateFromJson(Map<String, dynamic> json) =>
    AuthenticationState(
      eeclassUserData: json['eeclassUserData'] == null
          ? User.empty
          : User.fromJson(json['eeclassUserData'] as Map<String, dynamic>),
      eeclassAuthenticated: $enumDecodeNullable(
              _$AuthStatusEnumMap, json['eeclassAuthenticated']) ??
          AuthStatus.unauth,
      courseSelectUserData: json['courseSelectUserData'] == null
          ? User.empty
          : User.fromJson(json['courseSelectUserData'] as Map<String, dynamic>),
      courseSelectAuthenticated: $enumDecodeNullable(
              _$AuthStatusEnumMap, json['courseSelectAuthenticated']) ??
          AuthStatus.unauth,
    );

Map<String, dynamic> _$AuthenticationStateToJson(
        AuthenticationState instance) =>
    <String, dynamic>{
      'eeclassUserData': instance.eeclassUserData,
      'eeclassAuthenticated':
          _$AuthStatusEnumMap[instance.eeclassAuthenticated]!,
      'courseSelectUserData': instance.courseSelectUserData,
      'courseSelectAuthenticated':
          _$AuthStatusEnumMap[instance.courseSelectAuthenticated]!,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.loading: 'loading',
  AuthStatus.authed: 'authed',
  AuthStatus.unauth: 'unauth',
};
