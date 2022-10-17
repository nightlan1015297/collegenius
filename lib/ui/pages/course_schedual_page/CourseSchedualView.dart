import 'package:collegenius/logic/bloc/course_schedual_page_bloc.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:collegenius/ui/pages/course_schedual_page/WeeklySchedualSuccessView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collegenius/logic/bloc/authentication_bloc.dart' as authBloc;
import 'package:collegenius/repositories/course_schedual_repository.dart';
import 'package:collegenius/ui/pages/course_schedual_page/DailySchedualSuccessView.dart';
import 'package:collegenius/utilties/ticker.dart';

import 'CourseSchedualNotLoginView.dart';

class CourseSchedualView extends StatefulWidget {
  final CourseSchedualRepository courseSchedualRepository;
  const CourseSchedualView({
    Key? key,
    required this.courseSchedualRepository,
  }) : super(key: key);

  @override
  State<CourseSchedualView> createState() => _CourseSchedualViewState();
}

class _CourseSchedualViewState extends State<CourseSchedualView>
    with AutomaticKeepAliveClientMixin {
  late CourseSchedualPageBloc courseSchedualPageBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    courseSchedualPageBloc = CourseSchedualPageBloc(
        ticker: Ticker(),
        courseSchedualRepository: widget.courseSchedualRepository,
        authenticateBloc: context.read<authBloc.AuthenticationBloc>());
    courseSchedualPageBloc.add(InitializeRequest());
    return super.initState();
  }

  @override
  void dispose() {
    courseSchedualPageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    super.build(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight - 130),
      child: Builder(builder: (context) {
        return BlocProvider(
          create: (context) => courseSchedualPageBloc,
          child: BlocBuilder<CourseSchedualPageBloc, CourseSchedualPageState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              switch (state.status) {
                case CourseSchedualPageStatus.initial:
                case CourseSchedualPageStatus.loading:
                  return Center(child: Loading());
                case CourseSchedualPageStatus.success:
                  if (state.renderDaily) {
                    return DailySchedualSuccessView();
                  } else {
                    return WeeklySchedualSuccessView();
                  }
                case CourseSchedualPageStatus.failure:
                  return const Center(child: Text("Failed"));
                case CourseSchedualPageStatus.unauthenticated:
                  return const CourseSchedualNotLoginView();
              }
            },
          ),
        );
      }),
    );
  }
}
