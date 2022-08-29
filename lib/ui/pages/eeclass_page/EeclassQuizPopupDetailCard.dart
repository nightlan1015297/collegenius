import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/cubit/eeclass_quiz_detail_cubit.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:collegenius/ui/pages/eeclass_page/DownloadAttachmentTags.dart';
import 'package:collegenius/ui/scaffolds/HeroDialogScaffold.dart';

class EeclassQuizPopupDetailCard extends StatefulWidget {
  const EeclassQuizPopupDetailCard({
    Key? key,
    required this.quizUrl,
  }) : super(key: key);
  final String quizUrl;
  @override
  State<EeclassQuizPopupDetailCard> createState() =>
      _EeclassQuizPopupDetailCardState();
}

class _EeclassQuizPopupDetailCardState
    extends State<EeclassQuizPopupDetailCard> {
  late EeclassQuizDetailCubit eeclassQuizDetailCubit;

  @override
  void initState() {
    eeclassQuizDetailCubit = EeclassQuizDetailCubit(
      eeclassRepository: context.read<EeclassRepository>(),
    );
    eeclassQuizDetailCubit.onOpenPopupQuizCardRequest(quizUrl: widget.quizUrl);
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => eeclassQuizDetailCubit,
      child: BlocBuilder<EeclassQuizDetailCubit, EeclassQuizDetailState>(
        builder: (context, state) {
          switch (state.quizCardStatus) {
            case EeclassQuizDetailCardStatus.loading:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 450, maxHeight: 600),
                      child: Loading(),
                    ),
                  ),
                ),
              );
            case EeclassQuizDetailCardStatus.success:
              return EeclassPopUpQuizDetailSuccessCard(
                quizInformation: state.quizCardData!,
              );
            case EeclassQuizDetailCardStatus.failed:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 450, maxHeight: 600),
                      child: Text("Failed"),
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class ScoreDistributionBarData {
  final String interval;
  final int score;
  ScoreDistributionBarData(this.interval, this.score);
}

class _BarChart extends StatelessWidget {
  const _BarChart({
    Key? key,
    required this.distribution,
    required this.fullmarks,
  }) : super(key: key);
  final List<int> distribution;
  final int fullmarks;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: (distribution.reduce(max) + 5).toDouble(),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          fitInsideHorizontally: true,
          rotateAngle: 270,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 165, 194, 231),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == distribution.length - 1) {
      if (value * 10 == fullmarks) {
        text = '$fullmarks';
      } else {
        text = '${value.toInt() * 10}-$fullmarks';
      }
    } else {
      text = '${value.toInt() * 10}-${(value.toInt() + 1) * 10 - 1}';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 28,
      child: Text(text, style: style),
      angle: -0.5 * pi,
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 80,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  final _barsGradient = const LinearGradient(
    colors: [
      Colors.lightBlueAccent,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups {
    final List<BarChartGroupData> result = [];
    for (int i = 0; i < distribution.length; i++) {
      result.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: distribution[i].toDouble(),
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ));
    }
    return result;
  }
}

class EeclassPopUpQuizDetailSuccessCard extends StatelessWidget {
  const EeclassPopUpQuizDetailSuccessCard(
      {Key? key, required this.quizInformation})
      : super(key: key);
  final EeclassQuiz quizInformation;
  Widget _distributionChartBuilder(List<int> distribution, int fullMarks) {
    return AspectRatio(
        aspectRatio: 1.5,
        child: RotatedBox(
          quarterTurns: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                elevation: 5,
                color: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                child: _BarChart(
                  fullmarks: fullMarks,
                  distribution: distribution,
                )),
          ),
        ));
  }

  Widget _attachmentWidgetBuilder(
    List? attachments,
    BuildContext context,
  ) {
    if (attachments?.isEmpty ?? true) {
      return SizedBox();
    }
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    var widgetList = <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _locale.attachments,
          style: _theme.textTheme.labelLarge,
        ),
      ),
    ];

    for (var element in attachments!) {
      widgetList.add(
        DownloadAttachmentTags(element: element, theme: _theme),
      );
      if (element != attachments.last) {
        widgetList.add(Divider());
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetList,
      ),
    );
  }

  Widget _quizInformationWidgetBuilder(
      EeclassQuiz quizInfo, BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    var _widgetList = <Widget>[];
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: _locale.quizTitle,
          information: quizInfo.quizTitle,
          informationTexttheme: _theme.textTheme.bodyLarge,
          informationTextOverFlow: TextOverflow.visible,
        ),
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: _locale.quizTime,
          information: quizInfo.timeDuration,
          informationTexttheme: _theme.textTheme.bodyLarge,
          informationTextOverFlow: TextOverflow.visible,
        ),
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: _locale.timeLimit,
          information: quizInfo.timeLimit ?? "-",
          informationTexttheme: _theme.textTheme.bodyLarge,
          informationTextOverFlow: TextOverflow.visible,
        ),
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
              label: _locale.fullMarks,
              information: quizInfo.fullMarks?.round().toString() ?? "-",
              informationTextOverFlow: TextOverflow.visible,
            ),
          ),
          VerticalSeperater(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
              label: _locale.passingMarks,
              information: quizInfo.passingMarks?.round().toString() ?? "-",
              informationTextOverFlow: TextOverflow.visible,
            ),
          ),
          VerticalSeperater(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
              label: _locale.score,
              information: quizInfo.score?.round().toString() ?? "-",
              informationTextOverFlow: TextOverflow.visible,
            ),
          ),
          VerticalSeperater(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
              label: _locale.weights,
              information: quizInfo.percentage,
              informationTextOverFlow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: _locale.content,
          information: quizInfo.description,
          informationTexttheme: _theme.textTheme.bodyLarge,
          informationTextOverFlow: TextOverflow.visible,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _widgetList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return HeroDialogScaffold(
      child: Center(
        child: GestureDetector(
          onTap: () {
            /// Do nothing to cancel Navigator pop in HeroDialogScaffold
            /// prevent un neccesary pop when touch the pop up content
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 450, maxHeight: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      child: Stack(
                        children: [
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_locale.quizInformation,
                                  style: _theme.textTheme.titleLarge,
                                  textAlign: TextAlign.start),
                            ),
                            alignment: Alignment.center,
                          ),
                          Align(
                            child: IconButton(
                              icon: Icon(Icons.close, size: 30),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Builder(
                              builder: (context) {
                                if (quizInformation.scoreDistribution != null &&
                                    quizInformation.fullMarks?.toInt() !=
                                        null) {
                                  return _distributionChartBuilder(
                                      quizInformation.scoreDistribution!,
                                      quizInformation.fullMarks!.toInt());
                                }
                                return SizedBox();
                              },
                            ),
                            _quizInformationWidgetBuilder(
                                quizInformation, context),
                            _attachmentWidgetBuilder(
                                quizInformation.attachments, context),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
