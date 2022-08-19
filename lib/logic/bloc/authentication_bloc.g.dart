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
      eeclassAuthStatus:
          $enumDecodeNullable(_$AuthStatusEnumMap, json['eeclassAuthStatus']) ??
              AuthStatus.unauth,
      eeclassError: json['eeclassError'] == null
          ? null
          : ErrorModel.fromJson(json['eeclassError'] as Map<String, dynamic>),
      courseSelectUserData: json['courseSelectUserData'] == null
          ? User.empty
          : User.fromJson(json['courseSelectUserData'] as Map<String, dynamic>),
      courseSelectAuthStatus: $enumDecodeNullable(
              _$AuthStatusEnumMap, json['courseSelectAuthStatus']) ??
          AuthStatus.unauth,
      courseSelectError: json['courseSelectError'] == null
          ? null
          : ErrorModel.fromJson(
              json['courseSelectError'] as Map<String, dynamic>),
      portalUserData: json['portalUserData'] == null
          ? User.empty
          : User.fromJson(json['portalUserData'] as Map<String, dynamic>),
      portalAuthStatus: $enumDecodeNullable(
              _$PortalAuthStatusEnumMap, json['portalAuthStatus']) ??
          PortalAuthStatus.unauth,
      portalError: json['portalError'] == null
          ? null
          : ErrorModel.fromJson(json['portalError'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticationStateToJson(
        AuthenticationState instance) =>
    <String, dynamic>{
      'eeclassUserData': instance.eeclassUserData,
      'eeclassAuthStatus': _$AuthStatusEnumMap[instance.eeclassAuthStatus]!,
      'eeclassError': instance.eeclassError,
      'courseSelectUserData': instance.courseSelectUserData,
      'courseSelectAuthStatus':
          _$AuthStatusEnumMap[instance.courseSelectAuthStatus]!,
      'courseSelectError': instance.courseSelectError,
      'portalUserData': instance.portalUserData,
      'portalAuthStatus': _$PortalAuthStatusEnumMap[instance.portalAuthStatus]!,
      'portalError': instance.portalError,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.loading: 'loading',
  AuthStatus.authed: 'authed',
  AuthStatus.unauth: 'unauth',
};

const _$PortalAuthStatusEnumMap = {
  PortalAuthStatus.loading: 'loading',
  PortalAuthStatus.needCaptcha: 'needCaptcha',
  PortalAuthStatus.authed: 'authed',
  PortalAuthStatus.unauth: 'unauth',
};
