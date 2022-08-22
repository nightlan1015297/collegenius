import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/routes/route_arguments.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class EeclassQuizListView extends StatelessWidget {
  final List<EeclassQuizBrief> quizList;
  const EeclassQuizListView({
    Key? key,
    required this.quizList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _locale.quizOverview,
          style: _theme.textTheme.titleLarge,
        ),
        elevation: 0,
        iconTheme: _theme.iconTheme,
        backgroundColor: _theme.scaffoldBackgroundColor,
      ),
      body: Builder(builder: (context) {
        if (quizList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: quizList.length,
              itemBuilder: (context, index) {
                final quizInfoBrief = quizList[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: EeclassQuizCard(
                      quizTitle: quizInfoBrief.title,
                      quizDeadline: quizInfoBrief.deadLine,
                      quizUrl: quizInfoBrief.url,
                      score: quizInfoBrief.score?.round().toString() ?? "-"),
                );
              },
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _locale.noDataEmoticon,
                      style: _theme.textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w900),
                    )
                  ]),
              Text(_locale.noData),
            ],
          );
        }
      }),
    );
  }
}

class EeclassQuizCard extends StatelessWidget {
  final String quizTitle;
  final String quizDeadline;
  final String quizUrl;
  final String score;
  EeclassQuizCard({
    required this.quizTitle,
    required this.quizDeadline,
    required this.quizUrl,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constrains) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/eeclassCourse/quizzes/popup',
              arguments: EeclassQuizzPopupArguments(
                quizUrl: quizUrl,
              ),
            );
          },
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            quizTitle,
                            style: _theme.textTheme.headline6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: _theme.iconTheme.color,
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(children: [
                        SizedBox(
                          width: 140,
                          child: TextInformationProvider(
                              informationTextOverFlow: TextOverflow.ellipsis,
                              label: _locale.quizDate,
                              information: quizDeadline),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 50,
                          child: TextInformationProvider(
                              informationTextOverFlow: TextOverflow.ellipsis,
                              label: _locale.score,
                              information: score),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
            elevation: 5.0,
          ),
        );
      },
    );
  }
}
