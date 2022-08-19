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
      eeclassAuthStatus: json['eeclassAuthStatus'] ?? AuthStatus.unauth,
      eeclassError: json['eeclassError'] == null
          ? null
          : ErrorModel.fromJson(json['eeclassError'] as Map<String, dynamic>),
      courseSelectUserData: json['courseSelectUserData'] == null
          ? User.empty
          : User.fromJson(json['courseSelectUserData'] as Map<String, dynamic>),
      courseSelectAuthStatus:
          json['courseSelectAuthStatus'] ?? AuthStatus.unauth,
      courseSelectError: json['courseSelectError'] == null
          ? null
          : ErrorModel.fromJson(
              json['courseSelectError'] as Map<String, dynamic>),
      portalUserData: json['portalUserData'] == null
          ? User.empty
          : User.fromJson(json['portalUserData'] as Map<String, dynamic>),
      portalAuthStatus: json['portalAuthStatus'] ?? PortalAuthStatus.unauth,
      portalError: json['portalError'] == null
          ? null
          : ErrorModel.fromJson(json['portalError'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticationStateToJson(
        AuthenticationState instance) =>
    <String, dynamic>{
      'eeclassUserData': instance.eeclassUserData,
      'eeclassAuthStatus': instance.eeclassAuthStatus,
      'eeclassError': instance.eeclassError,
      'courseSelectUserData': instance.courseSelectUserData,
      'courseSelectAuthStatus': instance.courseSelectAuthStatus,
      'courseSelectError': instance.courseSelectError,
      'portalUserData': instance.portalUserData,
      'portalAuthStatus': instance.portalAuthStatus,
      'portalError': instance.portalError,
    };
