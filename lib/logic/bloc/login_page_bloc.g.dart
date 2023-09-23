// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPageState _$LoginPageStateFromJson(Map<String, dynamic> json) =>
    LoginPageState(
      progress:
          $enumDecodeNullable(_$SubmissionProgressEnumMap, json['progress']) ??
              SubmissionProgress.initial,
      status: $enumDecodeNullable(_$VerifyStatusEnumMap, json['status']) ??
          VerifyStatus.empty,
    );

Map<String, dynamic> _$LoginPageStateToJson(LoginPageState instance) =>
    <String, dynamic>{
      'status': _$VerifyStatusEnumMap[instance.status]!,
      'progress': _$SubmissionProgressEnumMap[instance.progress]!,
    };

const _$SubmissionProgressEnumMap = {
  SubmissionProgress.initial: 'initial',
  SubmissionProgress.success: 'success',
  SubmissionProgress.failed: 'failed',
};

const _$VerifyStatusEnumMap = {
  VerifyStatus.empty: 'empty',
  VerifyStatus.valid: 'valid',
  VerifyStatus.invalid: 'invalid',
};
