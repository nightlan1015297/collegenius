import 'dart:io';

import 'package:collegenius/logic/cubit/eeclass_quiz_detail_cubit.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:collegenius/constants/Constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

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

class EeclassPopUpQuizDetailSuccessCard extends StatelessWidget {
  const EeclassPopUpQuizDetailSuccessCard(
      {Key? key, required this.quizInformation})
      : super(key: key);
  final EeclassQuiz quizInformation;

  Widget _attachmentWidgetBuilder(List attachments, BuildContext context) {
    if (attachments.isEmpty) {
      return SizedBox();
    }
    final _theme = Theme.of(context);
    var widgetList = <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '附件',
          style: _theme.textTheme.labelLarge,
        ),
      ),
    ];

    for (var element in attachments) {
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
    var _widgetList = <Widget>[];
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: '測驗標題',
          information: quizInfo.quizTitle,
          informationTextOverFlow: TextOverflow.visible,
        ),
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: '考試時間',
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
          label: '測驗時間',
          information: quizInfo.timeDuration,
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
              label: '滿分',
              information: quizInfo.fullMarks?.round().toString() ?? "-",
              informationTextOverFlow: TextOverflow.visible,
            ),
          ),
          VerticalSeperater(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
              label: '及格分數',
              information: quizInfo.passingMarks?.round().toString() ?? "-",
              informationTextOverFlow: TextOverflow.visible,
            ),
          ),
          VerticalSeperater(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
              label: '得分',
              information: quizInfo.score?.round().toString() ?? "-",
              informationTextOverFlow: TextOverflow.visible,
            ),
          ),
          VerticalSeperater(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
              label: '權重',
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
          label: '內容',
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
    final jsonQuizInformation = quizInformation.toJson();
    return Center(
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
                          child: Text("測驗資訊",
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
                        _quizInformationWidgetBuilder(quizInformation, context),
                        _attachmentWidgetBuilder(
                            jsonQuizInformation['attachments'], context),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DownloadAttachmentTags extends StatelessWidget {
  const DownloadAttachmentTags({
    Key? key,
    required this.element,
    required ThemeData theme,
  })  : _theme = theme,
        super(key: key);

  final List element;
  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        SizedBox(
          width: 200,
          child: Text(
            element[0] ?? "",
            style: _theme.textTheme.bodyLarge,
            overflow: TextOverflow.visible,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            final eeclassRepo = context.read<EeclassRepository>();
            final cookiesString =
                await eeclassRepo.getCookiesStringForDownload();
            await FlutterDownloader.enqueue(
                headers: {
                  HttpHeaders.connectionHeader: 'keep-alive',
                  HttpHeaders.cookieHeader: cookiesString,
                },
                url: 'https://ncueeclass.ncu.edu.tw' + element[1],
                savedDir: "/storage/emulated/0/Download/Collegenius",
                showNotification: true,
                openFileFromNotification: true,
                saveInPublicStorage: true);
          },
          child: Text(
            "下載",
            style: _theme.textTheme.labelLarge,
          ),
        ),
        Spacer()
      ],
    );
  }
}
