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
      discription: json['discription'] as String,
      score: (json['score'] as num?)?.toDouble(),
      scoreDistributionUrl: json['scoreDistributionUrl'] as String?,
      quizRecordUrl: json['quizRecordUrl'] as String?,
      answerUrl: json['answerUrl'] as String?,
      scoreDistribution: (json['scoreDistribution'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
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
      'discription': instance.discription,
      'score': instance.score,
      'scoreDistributionUrl': instance.scoreDistributionUrl,
      'quizRecordUrl': instance.quizRecordUrl,
      'answerUrl': instance.answerUrl,
      'scoreDistribution': instance.scoreDistribution,
    };
