import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/eeclass_home_page_bloc.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/routes/route_arguments.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassUnauthticateView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EeclassCoursesListView extends StatefulWidget {
  @override
  State<EeclassCoursesListView> createState() => _EeclassCoursesListViewState();
}

class _EeclassCoursesListViewState extends State<EeclassCoursesListView> {
  late EeclassHomePageBloc eeclassHomePageBloc;
  @override
  void initState() {
    eeclassHomePageBloc = EeclassHomePageBloc(
      authenticateBloc: context.read<AuthenticationBloc>(),
      eeclassRepository: context.read<EeclassRepository>(),
    );
    eeclassHomePageBloc.add(InitializeRequest());
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => eeclassHomePageBloc,
      child: Builder(
        builder: (context) {
          final state = context.watch<EeclassHomePageBloc>().state;
          switch (state.status) {
            case EeclassHomePageStatus.unAuthentucated:
              return EeclassUnauthticateView();
            case EeclassHomePageStatus.initial:
              return Center(child: Loading(size: 120));
            case EeclassHomePageStatus.loading:
              return Center(child: Loading(size: 120));
            case EeclassHomePageStatus.success:
              return EeclassHomePageSuccessView();
            case EeclassHomePageStatus.failed:
              return Center(
                child: Text("failed"),
              );
          }
        },
      ),
    );
  }
}

class EeclassHomePageSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EeclassHomePageBloc, EeclassHomePageState>(
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
                  title: "Semester",
                  currentItem:
                      state.semesterList.indexOf(state.selectedSemester!),
                  itemlist: state.semesterList.map((e) => e.name).toList(),
                  onSelectedItemChanged: (index) => context
                      .read<EeclassHomePageBloc>()
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
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(children: [
                      SizedBox(
                        width: 110,
                        child: TextInformationProvider(
                            label: "課程代號", information: courseCode),
                      ),
                      VerticalSeperater(),
                      SizedBox(
                        width: 30,
                        child: TextInformationProvider(
                            label: "學分", information: credit),
                      ),
                      VerticalSeperater(),
                      Spacer(),
                      SizedBox(
                        width: 80,
                        child: TextInformationProvider(
                            informationTextOverFlow: TextOverflow.ellipsis,
                            label: "授課教師",
                            information: professor),
                      ),
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
