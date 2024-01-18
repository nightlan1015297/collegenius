import 'package:collegenius/logic/bloc/eeclass_course_page_bloc.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';

import 'package:collegenius/constants/Constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class QuizInformationCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EeclassCoursePageBloc, EeclassCoursePageState>(
      builder: (context, state) {
        switch (state.quizInfoStatus) {
          case EeclassQuizInfoStatus.loading:
            return QuizInformationLoadingCard();
          case EeclassQuizInfoStatus.good:
            return QuizInformationCard(
              quizName: state.firstQuizName,
              fullMarks: state.firstQuizFullmarks!,
              score: state.firstQuizscore!,
              mainColor: Colors.green,
              sideColor: Colors.green[100]!,
            );
          case EeclassQuizInfoStatus.normal:
            return QuizInformationCard(
              quizName: state.firstQuizName,
              fullMarks: state.firstQuizFullmarks!,
              score: state.firstQuizscore!,
              mainColor: Colors.yellow,
              sideColor: Colors.yellow[100]!,
            );
          case EeclassQuizInfoStatus.bad:
            return QuizInformationCard(
              quizName: state.firstQuizName,
              fullMarks: state.firstQuizFullmarks!,
              score: state.firstQuizscore!,
              mainColor: Colors.red,
              sideColor: Colors.red[100]!,
            );
          case EeclassQuizInfoStatus.canNotParse:
            return QuizInformationParseErrorCard(
              quizName: state.firstQuizName,
            );
          case EeclassQuizInfoStatus.noQuiz:
            return QuizInformationNoQuizCard();
        }
      },
    );
  }
}

class QuizInformationNoQuizCard extends StatelessWidget {
  const QuizInformationNoQuizCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.green, width: 10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                      width: constraints.maxWidth - 160,
                      height: 130,
                      child: Center(
                        child: TextInformationProvider(
                            labelTexttheme: _theme.textTheme.labelLarge,
                            label: _locale.latestScore,
                            informationTexttheme: _theme.textTheme.headline6,
                            informationMaxLines: 2,
                            information: '-'),
                      )),
                  Spacer(),
                  AnimatedPercentageIndicator(
                    mainColor: Colors.green,
                    sideColor: Colors.green[100]!,
                    percentage: 1,
                    child: Text(_locale.noQuiz),
                  )
                ],
              ),
            ),
          ));
    });
  }
}

class QuizInformationParseErrorCard extends StatelessWidget {
  const QuizInformationParseErrorCard({
    Key? key,
    required String? quizName,
  })  : quizName = quizName ?? "-",
        super(key: key);

  final String quizName;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;

    return LayoutBuilder(builder: (context, constraints) {
      return Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.orange, width: 10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                      width: constraints.maxWidth - 160,
                      height: 130,
                      child: Center(
                        child: TextInformationProvider(
                            labelTexttheme: _theme.textTheme.labelLarge,
                            label: _locale.latestScore,
                            informationTexttheme: _theme.textTheme.bodyLarge!
                                .copyWith(fontSize: 18),
                            informationMaxLines: 2,
                            information: quizName),
                      )),
                  Spacer(),
                  AnimatedPercentageIndicator(
                    mainColor: Colors.orange,
                    sideColor: Colors.orange[100]!,
                    percentage: 1,
                    child: Text(_locale.parseError),
                  )
                ],
              ),
            ),
          ));
    });
  }
}

class QuizInformationLoadingCard extends StatelessWidget {
  const QuizInformationLoadingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.blue, width: 10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                      width: constraints.maxWidth - 160,
                      height: 130,
                      child: Center(
                        child: TextInformationProvider(
                            labelTexttheme: _theme.textTheme.labelLarge,
                            label: _locale.latestScore,
                            informationTexttheme: _theme.textTheme.headline6,
                            informationMaxLines: 2,
                            information: _locale.loading),
                      )),
                  Spacer(),
                  SizedBox(
                    width: 120,
                    height: 130,
                    child: Center(
                      child: Loading(size: 80),
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}

class QuizInformationCard extends StatelessWidget {
  final String quizName;
  final Color mainColor;
  final Color sideColor;
  final int fullMarks;
  final int score;

  QuizInformationCard({
    Key? key,
    required this.mainColor,
    required this.sideColor,
    required double fullMarks,
    required double score,
    String? quizName,
  })  : fullMarks = fullMarks.round(),
        score = score.round(),
        quizName = quizName ?? "-",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: mainColor, width: 10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                      width: constraints.maxWidth - 160,
                      height: 130,
                      child: Center(
                        child: TextInformationProvider(
                            labelTexttheme: _theme.textTheme.labelLarge,
                            label: _locale.latestScore,
                            informationTexttheme: _theme.textTheme.headline6,
                            informationMaxLines: 2,
                            information: quizName),
                      )),
                  Spacer(),
                  AnimatedPercentageIndicator(
                    mainColor: mainColor,
                    sideColor: sideColor,
                    percentage: score / fullMarks,
                    child: Text(
                      "$score/$fullMarks",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}

class AnimatedPercentageIndicator extends StatelessWidget {
  final Widget child;
  final Color mainColor;
  final Color sideColor;
  final double percentage;

  const AnimatedPercentageIndicator(
      {Key? key,
      required this.mainColor,
      required this.sideColor,
      required this.percentage,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: percentage),
      child: SizedBox(
        width: 120,
        height: 130,
        child: Center(child: child),
      ),
      duration: Duration(milliseconds: 2000),
      curve: Curves.easeOutCubic,
      builder: (BuildContext context, double tweenVal, Widget? child) {
        return CustomPaint(
          willChange: true,
          painter: PercantageIndicator(
              percentage: tweenVal,
              radius: 50,
              mainColor: mainColor,
              sideColor: sideColor),
          child: child,
        );
      },
    );
  }
}

class PercantageIndicator extends CustomPainter {
  PercantageIndicator(
      {required this.mainColor,
      required this.sideColor,
      required this.percentage,
      required this.radius,
      required});
  final double percentage;
  final double radius;
  final Color mainColor;
  final Color sideColor;
  @override
  void paint(Canvas canvas, Size size) {
    // Get the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the gray background seen on the progress indicator
    // This will act as the background layer.
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.grey.shade700
        ..strokeWidth = 15,
    );

    // Create a new layer where we will be painting the
    // actual progress indicator
    //! Function [saveLayer()] is expensive and will cause performance issue
    //! Think twice to call.
    canvas.saveLayer(
      Rect.fromCenter(
          center: center, width: radius * 2.5, height: radius * 2.5),
      Paint(),
    );

    // Draw the light green portion of the progress indicator
    canvas.drawArc(
      Rect.fromCenter(center: center, width: radius * 2, height: radius * 2),
      vmath.radians(90),
      vmath.radians(360 * percentage),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = sideColor
        ..strokeWidth = 15,
    );

    // Draw the dark green portion of the progress indicator
    // Basically, this covers the entire progress indicator circle.
    // But because we have set the blending mode to srouce-in (BlendMode.srcIn),
    // only the segment that is overlapping with the lighter portion will be visible.
    canvas.drawArc(
      Rect.fromCenter(
          center: center, width: radius * 2 - 7.5, height: radius * 2 - 7.5),
      vmath.radians(90 - 15),
      vmath.radians(360),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = mainColor
        ..strokeWidth = 7.5
        ..blendMode = BlendMode.srcIn,
    );
    // we fatten the layer
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
