// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPageState _$LoginPageStateFromJson(Map<String, dynamic> json) =>
    LoginPageState(
      status: $enumDecodeNullable(_$FormzStatusEnumMap, json['status']) ??
          FormzStatus.pure,
    );

Map<String, dynamic> _$LoginPageStateToJson(LoginPageState instance) =>
    <String, dynamic>{
      'status': _$FormzStatusEnumMap[instance.status]!,
    };

const _$FormzStatusEnumMap = {
  FormzStatus.pure: 'pure',
  FormzStatus.valid: 'valid',
  FormzStatus.invalid: 'invalid',
  FormzStatus.submissionInProgress: 'submissionInProgress',
  FormzStatus.submissionSuccess: 'submissionSuccess',
  FormzStatus.submissionFailure: 'submissionFailure',
  FormzStatus.submissionCanceled: 'submissionCanceled',
};
