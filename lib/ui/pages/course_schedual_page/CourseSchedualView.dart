import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/cubit/course_schedual_page_cubit.dart';
import 'package:collegenius/repositories/course_schedual_repository.dart';
import 'package:collegenius/ui/pages/course_schedual_page/CourseSchedualSuccessView.dart';
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

class _CourseSchedualViewState extends State<CourseSchedualView> {
  late CourseSchedualPageCubit courseSchedualPageCubit;
  @override
  void initState() {
    courseSchedualPageCubit = CourseSchedualPageCubit(
        ticker: Ticker(),
        courseSchedualRepository: widget.courseSchedualRepository,
        authenticateBloc: context.read<AuthenticationBloc>());
    courseSchedualPageCubit.initState();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => courseSchedualPageCubit,
      child: BlocBuilder<CourseSchedualPageCubit, CourseSchedualPageState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            switch (state.status) {
              case CourseSchedualPageStatus.initial:
                return Center(child: Loading(size: 120));

              case CourseSchedualPageStatus.loading:
                return Center(child: Loading(size: 120));
              case CourseSchedualPageStatus.success:
                return CourseSchedualSuccessView();
              case CourseSchedualPageStatus.failure:
                return Center(child: Text("Failed"));

              case CourseSchedualPageStatus.unauthenticated:
                return const CourseSchedualNotLoginView();
            }
          }),
    );
  }
}
