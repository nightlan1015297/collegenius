import 'package:collegenius/logic/bloc/authentication_bloc.dart' as authbloc;
import 'package:collegenius/logic/bloc/eeclass_home_page_bloc.dart';
import 'package:collegenius/models/error_model/ErrorModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/routes/route_arguments.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:collegenius/ui/pages/eeclass_page/EeclassUnauthticateView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EeclassCoursesListView extends StatefulWidget {
  @override
  State<EeclassCoursesListView> createState() => _EeclassCoursesListViewState();
}

class _EeclassCoursesListViewState extends State<EeclassCoursesListView>
    with AutomaticKeepAliveClientMixin {
  late EeclassCourseListBloc eeclassCourseListBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    eeclassCourseListBloc = EeclassCourseListBloc(
      authenticateBloc: context.read<authbloc.AuthenticationBloc>(),
      eeclassRepository: context.read<EeclassRepository>(),
    );
    eeclassCourseListBloc.add(InitializeRequest());
    return super.initState();
  }

  @override
  void dispose() {
    eeclassCourseListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => eeclassCourseListBloc,
      child: BlocBuilder<EeclassCourseListBloc, EeclassCourseListState>(
        builder: (context, state) {
          super.build(context);
          switch (state.status) {
            case EeclassCourseListStatus.unAuthentucated:
              return EeclassUnauthticateView();
            case EeclassCourseListStatus.initial:
            case EeclassCourseListStatus.loading:
              return Center(child: Loading());
            case EeclassCourseListStatus.success:
              return EeclassCourseListSuccessView();
            case EeclassCourseListStatus.failed:
              return EeclassCourseListFailedView(err: state.error!);
          }
        },
      ),
    );
  }
}

class EeclassCourseListFailedView extends StatelessWidget {
  final ErrorModel err;
  const EeclassCourseListFailedView({
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
                  final eeclassCourseListBloc =
                      context.read<EeclassCourseListBloc>();
                  eeclassCourseListBloc.add(InitializeRequest());
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

class EeclassCourseListSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _locale = AppLocalizations.of(context)!;
    return BlocBuilder<EeclassCourseListBloc, EeclassCourseListState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 180,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Picker(
                  title: _locale.semesterPicker,
                  currentItem:
                      state.semesterList.indexOf(state.selectedSemester!),
                  itemlist: state.semesterList.map((e) => e.name).toList(),
                  onSelectedItemChanged: (index) => context
                      .read<EeclassCourseListBloc>()
                      .add(ChangeSemesterRequest(
                          semester: state.semesterList[index])),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.courseList.length,
                  itemBuilder: (contexe, index) {
                    final courseInfoBrief = state.courseList[index];
                    return EeclassCourseCard(
                      courseTitle: courseInfoBrief.name,
                      courseSerial: courseInfoBrief.courseSerial,
                      courseCode: courseInfoBrief.courseCode ?? "-",
                      credit: courseInfoBrief.credit ?? "-",
                      professor: courseInfoBrief.professor ?? "-",
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class EeclassCourseCard extends StatelessWidget {
  final String courseTitle;
  final String courseCode;
  final String credit;
  final String professor;
  final String courseSerial;
  EeclassCourseCard({
    required this.courseTitle,
    required this.courseCode,
    required this.credit,
    required this.professor,
    required this.courseSerial,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/eeclassCourse',
                arguments: EeclassCourseArguments(courseSerial: courseSerial));
          },
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          courseTitle,
                          style: _theme.textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: _theme.iconTheme.color,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(children: [
                      TextInformationProvider(
                          labelTexttheme: _theme.textTheme.bodyMedium,
                          informationTexttheme: _theme.textTheme.bodyMedium,
                          label: _locale.courseCode,
                          information: courseCode),
                      VerticalSeperater(),
                      TextInformationProvider(
                          labelTexttheme: _theme.textTheme.bodyMedium,
                          informationTexttheme: _theme.textTheme.bodyMedium,
                          label: _locale.credit,
                          information: credit),
                      Spacer(),
                      TextInformationProvider(
                          labelTexttheme: _theme.textTheme.bodyMedium,
                          informationTexttheme: _theme.textTheme.bodyMedium,
                          informationTextOverFlow: TextOverflow.ellipsis,
                          label: _locale.professor,
                          information: professor),
                    ]),
                  )
                ],
              ),
            ),
            elevation: 5.0,
          ),
        ),
      ),
    );
  }
}
