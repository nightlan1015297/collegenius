import 'package:collegenius/logic/bloc/authentication_bloc.dart' as authbloc;
import 'package:collegenius/logic/bloc/eeclass_course_page_bloc.dart';
import 'package:collegenius/models/eeclass_model/EeclassBullitinBrief.dart';
import 'package:collegenius/models/eeclass_model/EeclassCourseInformation.dart';
import 'package:collegenius/models/error_model/ErrorModel.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      authenticateBloc: context.read<authbloc.AuthenticationBloc>(),
      eeclassRepository: context.read<EeclassRepository>(),
    );
    eeclassCoursePageBloc.add(InitializeRequest());
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => eeclassCoursePageBloc,
      child: BlocBuilder<EeclassCoursePageBloc, EeclassCoursePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                _locale.courseDashboard,
                style: _theme.textTheme.titleLarge,
              ),
            ),
            body: Builder(
              builder: (context) {
                switch (state.status) {
                  case EeclassCoursePageStatus.unAuthentucated:
                    return EeclassUnauthticateView();
                  case EeclassCoursePageStatus.initial:
                  case EeclassCoursePageStatus.loading:
                    return Loading();
                  case EeclassCoursePageStatus.success:
                    return EeclassCoursePageSuccessView(
                        courseSerial: widget.courseSerial);
                  case EeclassCoursePageStatus.failed:
                    return EeclassCoursePageFailedView(err: state.error!);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class EeclassCoursePageFailedView extends StatelessWidget {
  final ErrorModel err;
  const EeclassCoursePageFailedView({
    Key? key,
    required this.err,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _locale.loadError,
                    style: _theme.textTheme.titleLarge,
                  )),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextInformationProvider(
                          label: '${_locale.exceptionDescription} :',
                          information: err.exception,
                          labelTexttheme: _theme.textTheme.titleLarge,
                          informationTextOverFlow: TextOverflow.visible,
                          informationTexttheme: _theme.textTheme.bodyLarge,
                          informationPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextInformationProvider(
                          label: '${_locale.errorStacktrace} :',
                          information: err.stackTrace,
                          informationTextOverFlow: TextOverflow.visible,
                          labelTexttheme: _theme.textTheme.titleLarge,
                          informationTexttheme: _theme.textTheme.bodyLarge,
                          informationPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final eeclassHomePageBloc =
                      context.read<EeclassCoursePageBloc>();
                  eeclassHomePageBloc.add(InitializeRequest());
                },
                child: Text(_locale.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EeclassCoursePageSuccessView extends StatelessWidget {
  const EeclassCoursePageSuccessView({
    Key? key,
    required this.courseSerial,
  }) : super(key: key);
  final String courseSerial;
  @override
  Widget build(BuildContext context) {
    final _locale = AppLocalizations.of(context)!;
    return BlocBuilder<EeclassCoursePageBloc, EeclassCoursePageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CourseInformationCard(),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/eeclassCourse/quizzes',
                        arguments: EeclassQuizzesPageArguments(
                          quizList: state.quizList,
                        ),
                      );
                    },
                    child: QuizInformationCardView()),
                CourseBullitinBoard(
                    courseSerial: courseSerial,
                    bullitinList: state.bullitinList),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
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
                                Text(_locale.materials),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
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
                                Text(_locale.assignments),
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

  const EeclassPopUpInformationCard({Key? key, required this.courseInformation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 600),
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
                          child: Text(_locale.courseInformation,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.classCode,
                            information: courseInformation.classCode ?? '-',
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.className,
                            information: courseInformation.name ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.credit,
                            information: courseInformation.credit ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.semester,
                            information: courseInformation.semester ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.division,
                            information: courseInformation.division ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.classes,
                            information: courseInformation.classes ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.members,
                            information: courseInformation.members ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.instroctors,
                            information:
                                courseInformation.instroctors?.join('\n') ??
                                    '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.assistants,
                            information:
                                courseInformation.assistants?.join('\n') ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.description,
                            information: courseInformation.description ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.syllabus,
                            information: courseInformation.syllabus ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.textbooks,
                            information: courseInformation.textbooks ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: _locale.gradingDescription,
                            information:
                                courseInformation.gradingDescription ?? '-',
                            labelTexttheme: _theme.textTheme.labelLarge,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationTextOverFlow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseInformationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _locale = AppLocalizations.of(context)!;
    return BlocBuilder<EeclassCoursePageBloc, EeclassCoursePageState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
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
                          maxWidth: constraints.maxWidth - 125,
                        ),
                        child: TextInformationProvider(
                            label: _locale.courseName,
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
        });
      },
    );
  }
}

class CourseBullitinBoard extends StatelessWidget {
  final List<EeclassBullitinBrief> bullitinList;
  final String courseSerial;
  const CourseBullitinBoard({
    Key? key,
    required this.bullitinList,
    required this.courseSerial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Card(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/eeclassCourse/bullitins',
                    arguments: EeclassBullitinsPageArguments(
                      courseSerial: courseSerial,
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                      child: Text(_locale.latestBullitin,
                          style: _theme.textTheme.titleLarge),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              ),
            ),
            Builder(builder: (context) {
              if (bullitinList.isEmpty) {
                return SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '(=\'X\'=)',
                                style: _theme.textTheme.displayMedium!
                                    .copyWith(fontWeight: FontWeight.w900),
                              )
                            ]),
                        Text('沒有資料'),
                      ],
                    ),
                  ),
                );
              }
              final itemLength;
              if (bullitinList.length > 3) {
                itemLength = 3;
              } else {
                itemLength = bullitinList.length;
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: itemLength,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/eeclassCourse/bullitins/popup',
                            arguments: EeclassBulliitinsPopupArguments(
                              bullitinBrief: bullitinList[index],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            bullitinList[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: _theme.textTheme.bodyLarge,
                          ),
                        ),
                      );
                    }),
              );
            })
          ],
        ),
      ),
    );
  }
}
