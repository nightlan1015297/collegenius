import 'dart:io';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:collegenius/ui/pages/eeclass_page/DownloadAttachmentTags.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/cubit/eeclass_quiz_detail_cubit.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';

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

class ScoreDistributionChart extends StatelessWidget {
  ScoreDistributionChart({
    Key? key,
    required this.distributionList,
    required this.fullMarks,
    required this.animate,
  }) : super(key: key);

  final List<int> distributionList;
  final int fullMarks;
  late List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    seriesList = generateData(distributionList, fullMarks);
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: charts.BarChart(
          seriesList,
          vertical: false,
          animate: animate,
          domainAxis: charts.OrdinalAxisSpec(
            renderSpec: charts.SmallTickRendererSpec(
              labelStyle: charts.TextStyleSpec(
                fontSize: 10,
                color: charts.MaterialPalette.white,
              ),
            ),
          ),
          defaultRenderer: charts.BarRendererConfig(
              // By default, bar renderer will draw rounded bars with a constant
              // radius of 100.
              // To not have any rounded corners, use [NoCornerStrategy]
              // To change the radius of the bars, use [ConstCornerStrategy]
              cornerStrategy: const charts.ConstCornerStrategy(30)),
        ),
      ),
    );
  }

  static List<charts.Series<ScoreDistributionBarData, String>> generateData(
      List<int> scoreDis, int fullmarks) {
    List<ScoreDistributionBarData> data = [];
    for (var i = 0; i < scoreDis.length; i++) {
      if (i == scoreDis.length - 1) {
        data.add(ScoreDistributionBarData('${i * 10}-$fullmarks', scoreDis[i]));
        break;
      }
      data.add(ScoreDistributionBarData(
          '${i * 10}-${(i + 1) * 10 - 1}', scoreDis[i]));
    }
    return [
      charts.Series<ScoreDistributionBarData, String>(
        id: 'ScoreDistribution',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ScoreDistributionBarData data, _) => data.interval,
        measureFn: (ScoreDistributionBarData data, _) => data.score,
        data: data,
      )
    ];
  }
}

class EeclassPopUpQuizDetailSuccessCard extends StatelessWidget {
  const EeclassPopUpQuizDetailSuccessCard(
      {Key? key, required this.quizInformation})
      : super(key: key);
  final EeclassQuiz quizInformation;
  Widget _distributionChartBuilder(List<int> distribution, int fullMarks) {
    return ScoreDistributionChart(
      distributionList: distribution,
      fullMarks: fullMarks,
      animate: true,
    );
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
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
