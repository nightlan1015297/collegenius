import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/eeclass_course_page_bloc.dart';
import 'package:collegenius/models/eeclass_model/EeclassCourseInformation.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/routes/route_arguments.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'EeclassUnauthticateView.dart';
import 'QuizInformationCardView.dart';

class EeclassCoursePage extends StatefulWidget {
  const EeclassCoursePage({Key? key, required this.courseSerial})
      : super(key: key);
  final String courseSerial;
  @override
  State<EeclassCoursePage> createState() => _EeclassCoursePageState();
}

class _EeclassCoursePageState extends State<EeclassCoursePage> {
  late EeclassCoursePageBloc eeclassCoursePageBloc;
  @override
  void initState() {
    eeclassCoursePageBloc = EeclassCoursePageBloc(
      courseSerial: widget.courseSerial,
      authenticateBloc: context.read<AuthenticationBloc>(),
      eeclassRepository: context.read<EeclassRepository>(),
    );
    eeclassCoursePageBloc.add(InitializeRequest());
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return BlocProvider(
      create: (context) => eeclassCoursePageBloc,
      child: BlocBuilder<EeclassCoursePageBloc, EeclassCoursePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Course dashboard",
                style: _theme.textTheme.titleLarge,
              ),
              elevation: 0,
              iconTheme: _theme.iconTheme,
              backgroundColor: _theme.scaffoldBackgroundColor,
            ),
            body: Builder(
              builder: (context) {
                switch (state.status) {
                  case EeclassCoursePageStatus.unAuthentucated:
                    return EeclassUnauthticateView();
                  case EeclassCoursePageStatus.initial:
                    return Loading();
                  case EeclassCoursePageStatus.loading:
                    return Loading();
                  case EeclassCoursePageStatus.success:
                    return EeclassCoursePageSuccessView();
                  case EeclassCoursePageStatus.failed:
                    return Center(
                      child: Text("Failed"),
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

class EeclassCoursePageSuccessView extends StatelessWidget {
  const EeclassCoursePageSuccessView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EeclassCoursePageBloc, EeclassCoursePageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CourseInformationCard(),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/eeclassCourse/quizzes',
                        arguments: EeclassQuizzesPageArguments(
                          quizList: state.quizList,
                        ),
                      );
                    },
                    child: QuizInformationCardView()),
                Builder(builder: (_) {
                  if (state.bullitinList.length > 3) {
                    return AtAGlanceCard(
                        title: "Latest Bulletin",
                        itemList: state.bullitinList
                            .sublist(0, 3)
                            .map((e) =>
                                AtAGlanceItem(title: e.title, url: e.url))
                            .toList());
                  } else if (state.bullitinList.isEmpty) {
                    return NoDataCard(title: "Latest Bulletin");
                  }
                  return AtAGlanceCard(
                    title: "Latest Bulletin",
                    itemList: state.bullitinList
                        .map((e) => AtAGlanceItem(title: e.title, url: e.url))
                        .toList(),
                  );
                }),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/eeclassCourse/materials',
                            arguments: EeclassMaterialsPageArguments(
                              materialList: state.materialList,
                            ),
                          );
                        },
                        child: Card(
                          child: SizedBox(
                            height: 120,
                            child: Column(
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.folder,
                                  size: 50,
                                ),
                                Text("課程講義"),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/eeclassCourse/assignments',
                            arguments: EeclassAssignmentsPageArguments(
                              assignmentList: state.assignmentList,
                            ),
                          );
                        },
                        child: Card(
                          child: SizedBox(
                            height: 120,
                            child: Column(
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.assignment,
                                  size: 50,
                                ),
                                Text("課程作業"),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EeclassPopUpInformationCard extends StatelessWidget {
  final EeclassCourseInformation courseInformation;
  static Map<String, String> mappInformationKeyToChinese = {
    'classCode': '課程代碼',
    'name': '課程名稱',
    'credit': '學分',
    'semester': '學期',
    'division': '單位',
    'classes': '班級',
    'members': '修課人數',
    'instroctors': '老師',
    'assistants': '助教',
    'description': '課程簡介',
    'syllabus': '課程大綱',
    'textbooks': '教科書',
    'gradingDescription': '成績說明'
  };

  const EeclassPopUpInformationCard({Key? key, required this.courseInformation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Center(
      child: Card(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
                child: Stack(
                  children: [
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("課程資訊",
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
                constraints: BoxConstraints(maxHeight: 560),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: 13,
                  itemBuilder: ((context, index) {
                    if (index < 7) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextInformationProvider(
                          label: mappInformationKeyToChinese.values
                              .elementAt(index),
                          information: courseInformation.toJson()[
                                  mappInformationKeyToChinese.keys
                                      .elementAt(index)] ??
                              '-',
                          labelTexttheme: _theme.textTheme.labelLarge,
                          informationTexttheme: _theme.textTheme.titleLarge,
                          informationTextOverFlow: TextOverflow.visible,
                        ),
                      );
                    } else if (index > 6 && index < 9) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextInformationProvider(
                          label: mappInformationKeyToChinese.values
                              .elementAt(index),
                          information: courseInformation
                                  .toJson()[mappInformationKeyToChinese.keys
                                      .elementAt(index)]
                                  ?.join("\n") ??
                              '-',
                          labelTexttheme: _theme.textTheme.labelLarge,
                          informationTexttheme: _theme.textTheme.titleLarge,
                          informationTextOverFlow: TextOverflow.visible,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextInformationProvider(
                          label: mappInformationKeyToChinese.values
                              .elementAt(index),
                          information: courseInformation.toJson()[
                                  mappInformationKeyToChinese.keys
                                      .elementAt(index)] ??
                              '-',
                          labelTexttheme: _theme.textTheme.labelLarge,
                          informationTexttheme: _theme.textTheme.bodyMedium,
                          informationTextOverFlow: TextOverflow.visible,
                        ),
                      );
                    }
                  }),
                  separatorBuilder: (context, index) => Divider(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CourseInformationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EeclassCoursePageBloc, EeclassCoursePageState>(
      builder: (context, state) {
        return Row(
          children: [
            Card(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: SizedBox(
                  height: 60,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 250,
                      ),
                      child: TextInformationProvider(
                          label: "課程名稱",
                          information: state.courseInformation.name ?? "-"))),
            )),
            Spacer(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/eeclassCourse/popupInfo',
                          arguments: EeclassPopupInfoArguments(
                            courseInfo: state.courseInformation,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AtAGlanceItem {
  final String title;
  final String url;

  AtAGlanceItem({required this.title, required this.url});
}

class NoDataCard extends StatelessWidget {
  final String title;

  const NoDataCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Card(
      child: SizedBox(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text(title, style: _theme.textTheme.labelLarge),
                ),
                Spacer()
              ],
            ),
            Expanded(
              child: Center(
                  child:
                      Text("No data", style: _theme.textTheme.headlineSmall)),
            ),
          ],
        ),
      ),
    );
  }
}

class AtAGlanceCard extends StatelessWidget {
  final String title;
  final List<AtAGlanceItem> itemList;

  const AtAGlanceCard({
    Key? key,
    required this.title,
    required this.itemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Card(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Text(title, style: _theme.textTheme.labelLarge),
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Text(
                        itemList[index].title,
                        overflow: TextOverflow.ellipsis,
                        style: _theme.textTheme.bodyLarge,
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
