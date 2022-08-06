import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/eeclass_home_page_bloc.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:collegenius/ui/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassUnauthticateView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'EeclassCoursePageView.dart';

class EeclassHomePageView extends StatefulWidget {
  @override
  State<EeclassHomePageView> createState() => _EeclassHomePageViewState();
}

class _EeclassHomePageViewState extends State<EeclassHomePageView> {
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
    final _theme = Theme.of(context);
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
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemExtent: 130,
                    shrinkWrap: true,
                    itemCount: state.courseList.length,
                    itemBuilder: (contexe, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  EeclassCoursePageView(
                                courseSerial:
                                    state.courseList[index].courseSerial!,
                              ),
                            ),
                          );
                        },
                        child: Card(
                            child: EeclassCourseCard(
                          courseTitle: state.courseList[index].name!,
                          informations: [
                            SizedBox(
                              width: 110,
                              child: InformationProvider(
                                  label: "課程代號",
                                  information:
                                      state.courseList[index].courseCode!),
                            ),
                            VerticalSeperater(),
                            SizedBox(
                              width: 30,
                              child: InformationProvider(
                                  label: "學分",
                                  information: state.courseList[index].credit!),
                            ),
                            VerticalSeperater(),
                            Spacer(),
                            SizedBox(
                              width: 80,
                              child: InformationProvider(
                                  informationTextOverFlow:
                                      TextOverflow.ellipsis,
                                  label: "授課教師",
                                  information:
                                      state.courseList[index].professor!),
                            ),
                          ],
                        )),
                      );
                    }),
              ),
            )
          ],
        );
      },
    );
  }
}

class EeclassCourseCard extends StatelessWidget {
  final courseTitle;
  final List<Widget>? informations;
  EeclassCourseCard({
    required this.courseTitle,
    this.informations,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constrains) {
        return Card(
          margin: EdgeInsets.zero,
          child: Container(
            padding: EdgeInsets.all(10),
            width: constrains.maxWidth - 20,
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        courseTitle,
                        style: _theme.textTheme.headlineSmall,
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
                  child: Row(children: informations ?? []),
                )
              ],
            ),
          ),
          elevation: 5.0,
        );
      },
    );
  }
}
