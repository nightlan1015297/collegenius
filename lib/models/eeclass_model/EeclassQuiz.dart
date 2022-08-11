import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassQuiz.g.dart';

@JsonSerializable()
class EeclassQuiz extends Equatable {
  final bool isPaperQuiz;
  final String quizTitle;
  final String timeDuration;
  final String percentage;
  final double? fullMarks;
  final double? passingMarks;
  final String? timeLimit;
  final String discription;
  final double? score;
  final String? scoreDistributionUrl;
  final String? quizRecordUrl;
  final String? answerUrl;
  final List? attachments;
  final List<int>? scoreDistribution;

  EeclassQuiz({
    required this.isPaperQuiz,
    required this.quizTitle,
    required this.timeDuration,
    required this.percentage,
    this.fullMarks,
    this.passingMarks,
    this.timeLimit,
    required this.discription,
    this.score,
    this.scoreDistributionUrl,
    this.quizRecordUrl,
    this.answerUrl,
    this.scoreDistribution,
    this.attachments,
  });

  factory EeclassQuiz.fromJson(Map<String, dynamic> data) =>
      _$EeclassQuizFromJson(data);
  Map<String, dynamic> toJson() => _$EeclassQuizToJson(this);
  @override
  List<Object?> get props => [
        isPaperQuiz,
        quizTitle,
        timeDuration,
        percentage,
        fullMarks,
        passingMarks,
        timeLimit,
        discription,
        score,
        scoreDistributionUrl,
        quizRecordUrl,
        answerUrl,
        scoreDistribution,
        attachments
      ];
}
