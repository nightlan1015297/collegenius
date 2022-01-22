import 'package:collegenius/constants/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collegenius/logic/cubit/course_schedual_cubit.dart';
import 'package:collegenius/logic/cubit/course_section_cubit.dart';
import 'package:collegenius/ui/widgets/information_provider.dart';
import 'package:collegenius/ui/widgets/node_graph_widget.dart';
import 'package:collegenius/ui/widgets/picker.dart';

Map<String, String> _sectionToTime = {
  'one': '8:',
  'two': '9:',
  'three': '10:',
  'four': '11:',
  'Z': '12:',
  'five': '13:',
  'six': '14:',
  'seven': '15:',
  'eight': '16:',
  'nine': '17:',
  'A': '18:',
  'B': '19:',
  'C': '20:',
  'D': '21:',
  'E': '22:',
  'F': '23:'
};
Map<int, String> _indexToSection = {
  0: 'one',
  1: 'two',
  2: 'three',
  3: 'four',
  5: 'Z',
  6: 'five',
  7: 'six',
  8: 'seven',
  9: 'eight',
  10: 'nine',
  11: 'A',
  12: 'B',
  13: 'C',
  14: 'D',
  15: 'E',
  16: 'F'
};
Map<int, String> _indexToWeekday = {
  0: 'monday',
  1: 'tuesday',
  2: 'wednesday',
  3: 'thursday',
  4: 'friday',
  5: 'saturday',
  6: 'sunday',
};
final weekDayList = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];
final semesterList = [
  '1101',
  '1102',
];

class CourseSchedualBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final _courseSchedualState = context.watch<CourseSchedualCubit>().state;
      final _courseSectionState = context.watch<CoursesectionCubit>().state;
      if (_courseSchedualState.status.isInitial) {
        context
            .read<CourseSchedualCubit>()
            .fetchCourseSchedual(_courseSectionState.choosenSemester);
      }
      switch (_courseSchedualState.status) {
        case CourseSchedualStatus.initial:
          return Center(child: Text("Loading"));
        case CourseSchedualStatus.loading:
          return Center(child: Text("Loading"));
        case CourseSchedualStatus.success:
          final schedual = _courseSchedualState.schedual.toJson();
          final selectedDays =
              _indexToWeekday[_courseSectionState.choosenDays] ?? 'monday';
          /* Iter all courses in schedual to get the last class 
             last class will determine how many item will rendered on th screen
             to avoid unnecessary blank
          */
          var lastClass = 0;
          for (int i = 0; i < 16; i++) {
            if (schedual[selectedDays][_indexToSection[i]] != null) {
              lastClass = i;
            }
          }
          if (_courseSectionState.choosenDays ==
                  _courseSectionState.currentDays &&
              _courseSectionState.choosenSemester ==
                  _courseSectionState.currentSemester) {
            /* If the choosen condition fitted the current date 
                       Render animated course schedual to let user know
                       what is next courses etc ...
                    */
            return Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      WeekDayPicker(),
                      SemesterPicker(),
                    ],
                  ),
                ),
                AnimatedCourseSchedual(
                  renderLength: lastClass,
                  coursePerDay: schedual[selectedDays],
                  currentSection: _courseSectionState.cerrentSection,
                )
              ],
            );
          }
          /* 
             If not the current condition then just render 
             the normal one for browsing perpose.
          */
          return Column(
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    WeekDayPicker(),
                    SemesterPicker(),
                  ],
                ),
              ),
              NormalCourseSchedual(
                  renderLength: lastClass, coursePerDay: schedual[selectedDays])
            ],
          );
        case CourseSchedualStatus.failure:
          return Center(child: Text("Failed"));
      }
    });
  }
}

class WeekDayPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Picker(
          onSelectedItemChanged: (index) {
            context.read<CoursesectionCubit>().changeSelectedDays(index);
          },
          title: 'Days',
          currentItem: context.watch<CoursesectionCubit>().state.choosenDays,
          itemlist: weekDayList,
        ));
  }
}

class SemesterPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* Read the Cubits first avoid read multiple time when choosing semester*/
    var _coursesectionCubit = context.read<CoursesectionCubit>();
    var _courseSchedualCubit = context.read<CourseSchedualCubit>();
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Picker(
          onSelectedItemChanged: (index) {
            _coursesectionCubit.changeSelectedSemester(semesterList[index]);
            /* Reset the status of CourseSchedualCubit to initial
               Which will let CourseSchedualCubit reload data when 
               repainting CourseSchedualBody.
            */
            _courseSchedualCubit.changeStatus(CourseSchedualStatus.initial);
          },
          currentItem: semesterList.indexOf(
              context.watch<CoursesectionCubit>().state.choosenSemester),
          title: 'Semester',
          itemlist: semesterList,
        ));
  }
}

class NormalCourseSchedual extends StatelessWidget {
  final Map<String, dynamic> coursePerDay;
  final int renderLength;

  const NormalCourseSchedual({
    Key? key,
    required this.coursePerDay,
    required this.renderLength,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _renderedFirst = false;
    return Expanded(
      child: ListView.builder(
          itemCount: renderLength + 2,
          itemBuilder: (context, index) {
            final _section = _indexToSection[index];
            final _time = _sectionToTime[_section];
            final starttime, endtime;
            if (_time == null) {
              starttime = '--:--';
              endtime = '--:--';
            } else {
              starttime = _time + "00";
              endtime = _time + "50";
            }
            final _courseInfo = coursePerDay[_section];

            return LayoutBuilder(builder: (context, constrains) {
              if (_courseInfo == null) {
                if (!_renderedFirst) {
                  return SizedBox();
                }
                return SpaceCourseCard();
              }
              _renderedFirst = true;
              final classroom;
              if (_courseInfo['classroom'] != null) {
                var _splited = _courseInfo['classroom'].split('-');
                if (codeToClass[_splited[0]] != null) {
                  classroom = codeToClass[_splited[0]]! + ' ' + _splited[1];
                } else {
                  classroom = _courseInfo['classroom'];
                }
              } else {
                classroom = 'Unknown';
              }
              return NormalCourseCard(
                coursename: _courseInfo['name'],
                endTime: endtime,
                location: classroom,
                startTime: starttime,
                teacher: _courseInfo['professer'],
              );
            });
          }),
    );
  }
}

/* Animated Schedual will render animate which let user know the schedual in current day */
class AnimatedCourseSchedual extends StatelessWidget {
  final Map<String, dynamic> coursePerDay;
  final int currentSection;
  final int renderLength;
  const AnimatedCourseSchedual({
    Key? key,
    required this.coursePerDay,
    required this.currentSection,
    required this.renderLength,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: renderLength + 2,
          itemBuilder: (context, index) {
            final _section = _indexToSection[index];
            final _time = _sectionToTime[_section];
            final starttime, endtime;
            if (_time == null) {
              starttime = '--:--';
              endtime = '--:--';
            } else {
              starttime = _time + "00";
              endtime = _time + "50";
            }
            final _courseInfo = coursePerDay[_section];

            return LayoutBuilder(builder: (context, constrains) {
              if (_courseInfo == null) {
                if (index < currentSection) {
                  return Opacity(opacity: 0.3, child: SpaceCourseCard());
                } else {
                  return SpaceCourseCard();
                }
              }
              if (index < currentSection) {
                final classroom;
                if (_courseInfo['classroom'] != null) {
                  var _splited = _courseInfo['classroom'].split('-');
                  if (codeToClass[_splited[0]] != null) {
                    classroom = codeToClass[_splited[0]]! + ' ' + _splited[1];
                  } else {
                    classroom = _courseInfo['classroom'];
                  }
                } else {
                  classroom = 'Unknown';
                }
                return Opacity(
                  opacity: 0.3,
                  child: NormalCourseCard(
                    coursename: _courseInfo['name'],
                    endTime: endtime,
                    location: classroom,
                    startTime: starttime,
                    teacher: _courseInfo['professer'],
                  ),
                );
              } else if (index == currentSection) {
                return ProgressingCourseCard(
                  coursename: _courseInfo['name'],
                  endTime: endtime,
                  location: _courseInfo['classroom'],
                  startTime: starttime,
                  teacher: _courseInfo['professer'],
                );
              }
              return NormalCourseCard(
                coursename: _courseInfo['name'],
                endTime: endtime,
                location: _courseInfo['classroom'],
                startTime: starttime,
                teacher: _courseInfo['professer'],
              );
            });
          }),
    );
  }
}

class RegulerNode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          TimeLineNode(),
          TimeLineLine(),
        ],
      ),
    );
  }
}

class DottedNode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          TimeLineDottedNode(),
          TimeLineDottedLine(),
        ],
      ),
    );
  }
}

class SpaceCourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TimeLineShortLine(),
            ),
          ],
        )
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  final courseTitle;
  final List<Widget>? tags;
  final List<Widget>? informations;
  CourseCard({
    required this.courseTitle,
    this.tags,
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
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        courseTitle,
                        style: _theme.textTheme.headline5,
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
                Row(children: tags ?? []),
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

class Tag extends StatelessWidget {
  final tagHeight = 30.0;
  final String tagText;
  final Color color;

  Tag({
    required this.tagText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tagHeight,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Baseline(
        baseline: tagHeight / 2,
        baselineType: TextBaseline.alphabetic,
        child: Text(
          tagText,
          style: TextStyle(
            height: 1,
            fontSize: 16,
            color: color,
          ),
        ),
      ),
    );
  }
}

class ProgressingCourseCard extends StatelessWidget {
  final String coursename;
  final String location;
  final String teacher;
  final String startTime;
  final String endTime;
  const ProgressingCourseCard({
    Key? key,
    required this.coursename,
    required this.location,
    required this.teacher,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final _theme = Theme.of(context);
      return Row(
        children: [
          DottedNode(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: constrains.maxWidth - 70,
              child: CourseCard(
                courseTitle: coursename,
                tags: [
                  Tag(
                    color: Colors.green,
                    tagText: '正在進行',
                  ),
                  Tag(
                    color: Colors.blue,
                    tagText: startTime + '~' + endTime,
                  ),
                ],
                informations: [
                  InformationProvider(
                    label: '上課教室',
                    information: location,
                    informationTexttheme: _theme.textTheme.headline6,
                  ),
                  VerticalSeperater(),
                  InformationProvider(label: '授課教師', information: teacher)
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class NormalCourseCard extends StatelessWidget {
  final String coursename;
  final String location;
  final String teacher;
  final String startTime;
  final String endTime;
  const NormalCourseCard({
    Key? key,
    required this.coursename,
    required this.location,
    required this.teacher,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final _theme = Theme.of(context);
      return Row(
        children: [
          RegulerNode(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: constrains.maxWidth - 70,
              child: CourseCard(
                courseTitle: coursename,
                tags: [
                  Tag(
                    color: Colors.blue,
                    tagText: startTime + '~' + endTime,
                  ),
                ],
                informations: [
                  InformationProvider(
                    flex: 6,
                    label: '上課教室',
                    information: location,
                    informationTexttheme: _theme.textTheme.headline6,
                  ),
                  VerticalSeperater(),
                  InformationProvider(
                    flex: 4,
                    label: '授課教師',
                    information: teacher,
                    informationTexttheme: _theme.textTheme.headline6,
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
