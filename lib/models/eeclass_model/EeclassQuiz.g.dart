// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EeclassQuiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EeclassQuiz _$EeclassQuizFromJson(Map<String, dynamic> json) => EeclassQuiz(
      isPaperQuiz: json['isPaperQuiz'] as bool,
      quizTitle: json['quizTitle'] as String,
      timeDuration: json['timeDuration'] as String,
      percentage: json['percentage'] as String,
      fullMarks: (json['fullMarks'] as num?)?.toDouble(),
      passingMarks: (json['passingMarks'] as num?)?.toDouble(),
      timeLimit: json['timeLimit'] as String?,
      description: json['description'] as String,
      score: (json['score'] as num?)?.toDouble(),
      scoreDistributionUrl: json['scoreDistributionUrl'] as String?,
      quizRecordUrl: json['quizRecordUrl'] as String?,
      answerUrl: json['answerUrl'] as String?,
      scoreDistribution: (json['scoreDistribution'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      attachments: json['attachments'] as List<dynamic>?,
    );

Map<String, dynamic> _$EeclassQuizToJson(EeclassQuiz instance) =>
    <String, dynamic>{
      'isPaperQuiz': instance.isPaperQuiz,
      'quizTitle': instance.quizTitle,
      'timeDuration': instance.timeDuration,
      'percentage': instance.percentage,
      'fullMarks': instance.fullMarks,
      'passingMarks': instance.passingMarks,
      'timeLimit': instance.timeLimit,
      'description': instance.description,
      'score': instance.score,
      'scoreDistributionUrl': instance.scoreDistributionUrl,
      'quizRecordUrl': instance.quizRecordUrl,
      'answerUrl': instance.answerUrl,
      'attachments': instance.attachments,
      'scoreDistribution': instance.scoreDistribution,
    };
