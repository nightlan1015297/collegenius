import 'dart:io';

import 'package:collegenius/logic/cubit/eeclass_quiz_detail_cubit.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassUnauthticateView.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class EeclassQuizPopupDetailCard extends StatefulWidget {
  const EeclassQuizPopupDetailCard({
    Key? key,
    required this.heroKey,
    required this.quizUrl,
  }) : super(key: key);
  final String quizUrl;
  final UniqueKey heroKey;
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
          return Hero(
            tag: widget.heroKey,
            child: Builder(
              builder: (context) {
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
                    return EeclassPopUpQuizInformationSuccessCard(
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
                  case EeclassQuizDetailCardStatus.unauthenticate:
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: 450, maxHeight: 600),
                            child: EeclassUnauthticateView(),
                          ),
                        ),
                      ),
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class EeclassPopUpQuizInformationSuccessCard extends StatefulWidget {
  const EeclassPopUpQuizInformationSuccessCard(
      {Key? key, required this.quizInformation})
      : super(key: key);
  final EeclassQuiz quizInformation;

  @override
  State<EeclassPopUpQuizInformationSuccessCard> createState() =>
      _EeclassPopUpQuizInformationSuccessCardState();
}

class _EeclassPopUpQuizInformationSuccessCardState
    extends State<EeclassPopUpQuizInformationSuccessCard> {
  static Map<String, String> mapQuizInformationKeyToChinese = {
    'quizTitle': '測驗標題',
    'timeDuration': '考試時間',
    'percentage': '權重',
    'fullMarks': '滿分',
    'passingMarks': '及格分數',
    'discription': '內容',
    'attachments': '附件',
  };

  Widget _attachmentWidgetBuilder(List attachments, BuildContext context) {
    final _theme = Theme.of(context);
    var widgetList = <Widget>[
      Text(
        mapQuizInformationKeyToChinese['attachments']!,
        style: _theme.textTheme.labelLarge,
      ),
    ];
    for (var element in attachments) {
      widgetList.add(
        RichText(
          text: TextSpan(
            style: _theme.textTheme.bodyLarge!.copyWith(
              color: Colors.blue,
            ),
            text: element[0],
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final eeclassRepo = context.read<EeclassRepository>();
                final cookiesString =
                    await eeclassRepo.getCookiesStringForDownload();
                await FlutterDownloader.enqueue(
                    headers: {
                      HttpHeaders.connectionHeader: 'keep-alive',
                      HttpHeaders.cookieHeader: cookiesString,
                    },
                    url: 'https://ncueeclass.ncu.edu.tw' + element[1],
                    savedDir: "/storage/emulated/0/Download/",
                    showNotification: true,
                    openFileFromNotification: true,
                    saveInPublicStorage: true);
              },
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final jsonQuizInformation = widget.quizInformation.toJson();
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
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 550),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: ((context, index) {
                        final _key = mapQuizInformationKeyToChinese.keys
                            .elementAt(index);
                        if (index == 3 || index == 4) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextInformationProvider(
                              label: mapQuizInformationKeyToChinese[_key]!,
                              information: jsonQuizInformation[_key]
                                      ?.round()
                                      .toString() ??
                                  "-",
                              informationTexttheme: _theme.textTheme.bodyLarge,
                              informationTextOverFlow: TextOverflow.visible,
                            ),
                          );
                        } else if (index == 6) {
                          if (jsonQuizInformation['attachments'].isNotEmpty) {
                            return _attachmentWidgetBuilder(
                                jsonQuizInformation['attachments'], context);
                          } else {
                            return SizedBox();
                          }
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextInformationProvider(
                              label: mapQuizInformationKeyToChinese[_key]!,
                              information: jsonQuizInformation[_key] ?? "-",
                              informationTexttheme: _theme.textTheme.bodyLarge,
                              informationTextOverFlow: TextOverflow.visible,
                            ),
                          );
                        }
                      }),
                      separatorBuilder: (context, index) => Divider(),
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
