import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/constants/maps.dart';
import 'package:collegenius/logic/bloc/course_schedual_page_bloc.dart';
import 'package:collegenius/ui/pages/course_schedual_page/DailySchedualSuccessView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeeklySchedualSuccessView extends StatefulWidget {
  @override
  State<WeeklySchedualSuccessView> createState() =>
      _WeeklySchedualSuccessViewState();
}

class _WeeklySchedualSuccessViewState extends State<WeeklySchedualSuccessView> {
  final double sectionHeight = 80;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final daysWidth = maxWidth / 8;
    final weekDayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return BlocBuilder<CourseSchedualPageBloc, CourseSchedualPageState>(
        builder: (context, state) {
      if (state.schedual == null) {
        return NoCoursesCard();
      }

      final courses = <Widget>[];
      final jsonSchedual = state.schedual!.toJson();

      for (int day = 0; day < 7; day++) {
        final dailyJsonData = jsonSchedual[mapIndexToWeekday[day]];
        var temp;
        var combinedLength = 0;
        for (int section = 0; section < 16; section++) {
          final course = dailyJsonData[mapIndexToSection[section]];
          if (course?['name'] == temp?['name']) {
            combinedLength++;
          } else {
            if (temp == null) {
              temp = course;
              combinedLength = 1;
              continue;
            } else {
              courses.add(Positioned(
                  left: day * daysWidth,
                  top: (section - combinedLength) * sectionHeight,
                  child: SizedBox(
                      width: daysWidth,
                      height: combinedLength * sectionHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                            color: Colors.blue, child: Text(temp['name'])),
                      ))));
              temp = course;
              combinedLength = 1;
            }
          }
        }
      }
      return Column(children: [
        Row(
          children: [
            Expanded(
              child: Card(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Row(
                children: [
                  for (var i in weekDayList)
                    Expanded(
                      child: Card(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(child: Text(i)),
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Row(children: [
          Flexible(
              flex: 1,
              child: Column(
                children: [
                  for (var sec in courseSections)
                    SizedBox(
                        width: double.infinity,
                        height: sectionHeight,
                        child: Card(
                            child: Center(
                          child: Text(
                            "${mapCourseSectionToTime[sec]!}00\n${mapCourseSectionToTime[sec]!}50",
                            textAlign: TextAlign.center,
                          ),
                        ))),
                ],
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 7,
              child: SizedBox(
                  height: 16 * sectionHeight,
                  child: Stack(
                    children: courses,
                  )))
        ])))
      ]);
    });
  }
}
