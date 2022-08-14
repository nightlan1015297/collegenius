import 'package:collegenius/constants/maps.dart';
import 'package:collegenius/logic/cubit/course_schedual_page_cubit.dart';
import 'package:collegenius/routes/hero_dialog_route.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:collegenius/ui/pages/course_schedual_page/node_graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This Map[sectionToTime] map the section to it start hour.
Map<String, String> sectionToTime = {
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
Map<int, String> indexToSection = {
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
Map<int, String> indexToWeekday = {
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

class CourseSchedualSuccessView extends StatelessWidget {
  const CourseSchedualSuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 10),
            SizedBox(width: 200, child: WeekDayPicker()),
            SizedBox(width: 130, child: SemesterPicker()),
          ],
        ),
        BlocBuilder<CourseSchedualPageCubit, CourseSchedualPageState>(
          builder: (context, state) {
            final schedual = state.schedual;
            if (schedual == null) {
              return Center(child: Text("No Data record"));
            }
            final jsonSchedual = schedual.toJson();
            final selectedDays = indexToWeekday[state.selectedDays];

            /// Iter all courses in schedual to get the last class
            /// last class will determine how many item will rendered on th screen
            /// to avoid unnecessary blank

            var firstClass = 0;
            var lastClass = 0;
            var isFirst = false;
            for (int i = 0; i < 16; i++) {
              if (jsonSchedual[selectedDays][indexToSection[i]] != null) {
                if (!isFirst) {
                  firstClass = i;
                  isFirst = !isFirst;
                }
                lastClass = i;
              }
            }
            if (firstClass == lastClass && firstClass == 0) {
              return Center(child: Text("No Class Today"));
            }
            if (state.selectedDays == state.currentDays &&
                state.selectedSemester == state.currentSemester) {
              /// If the choosen condition fitted the current date
              /// Render animated course schedual to let user know
              /// what is next courses etc ...

              return AnimatedCourseSchedual(
                renderFrom: firstClass,
                renderLength: lastClass,
                coursePerDay: jsonSchedual[selectedDays],
                currentSection: state.cerrentSection,
              );
            }

            ///If not the current condition then just render
            ///the normal one for browsing perpose.

            return NormalCourseSchedual(
                renderFrom: firstClass,
                renderLength: lastClass,
                coursePerDay: jsonSchedual[selectedDays]);
          },
        )
      ],
    );
  }
}

class WeekDayPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSchedualPageCubit, CourseSchedualPageState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            child: Picker(
              key: UniqueKey(),
              onSelectedItemChanged: (index) {
                context.read<CourseSchedualPageCubit>().changeDays(days: index);
              },
              title: 'Days',
              currentItem: state.selectedDays,
              itemlist: weekDayList,
            ));
      },
    );
  }
}

class SemesterPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* Read the Cubits first avoid read multiple time when choosing semester*/
    var _courseSchedualPageCubit =
        context.watch<CourseSchedualPageCubit>().state;
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Picker(
          key: UniqueKey(),
          onSelectedItemChanged: (index) {
            context.read<CourseSchedualPageCubit>().changeSemester(
                semester: _courseSchedualPageCubit.semesterList[index].value);
          },
          currentItem: _courseSchedualPageCubit.semesterList
              .map((e) => e.value)
              .toList()
              .indexOf(_courseSchedualPageCubit.selectedSemester),
          title: 'Semester',
          itemlist:
              _courseSchedualPageCubit.semesterList.map((e) => e.name).toList(),
        ));
  }
}

class NormalCourseSchedual extends StatelessWidget {
  final Map<String, dynamic> coursePerDay;
  final int renderLength;
  final int renderFrom;
  const NormalCourseSchedual({
    Key? key,
    required this.coursePerDay,
    required this.renderLength,
    required this.renderFrom,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: renderLength + 1,
            itemBuilder: (context, index) {
              final _section = indexToSection[index];
              final _time = sectionToTime[_section];
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
                  if (renderFrom > index) {
                    return SizedBox();
                  }
                  return SpaceCourseCard();
                }
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
      ),
    );
  }
}

/* Animated Schedual will render animate which let user know the schedual in current day */
class AnimatedCourseSchedual extends StatelessWidget {
  final Map<String, dynamic> coursePerDay;
  final int currentSection;
  final int renderFrom;
  final int renderLength;
  const AnimatedCourseSchedual({
    Key? key,
    required this.coursePerDay,
    required this.currentSection,
    required this.renderFrom,
    required this.renderLength,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: renderLength + 2,
        itemBuilder: (context, index) {
          final _section = indexToSection[index];
          final _time = sectionToTime[_section];
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
              if (renderFrom > index) {
                return SizedBox();
              }
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
        });
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
  final List<Tag>? tags;
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
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              height: 110,
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(children: informations ?? []),
                  )
                ],
              ),
            ),
          ),
          elevation: 5.0,
        );
      },
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
                    color: Colors.blueAccent,
                    tagText: startTime + ' - ' + endTime,
                  ),
                ],
                informations: [
                  TextInformationProvider(
                    label: '上課教室',
                    information: location,
                    informationTexttheme: _theme.textTheme.headline6,
                  ),
                  VerticalSeperater(),
                  TextInformationProvider(label: '授課教師', information: teacher)
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class PopupInformationCard extends StatelessWidget {
  const PopupInformationCard(
      {Key? key,
      required this.coursename,
      required this.location,
      required this.teacher})
      : super(key: key);

  final String coursename;
  final String location;
  final String teacher;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 480, maxHeight: 640),
        child: Card(
          child: SingleChildScrollView(
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
                          child: Text("課程資訊",
                              style: _theme.textTheme.titleLarge,
                              textAlign: TextAlign.start),
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 30,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        alignment: Alignment.centerRight,
                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: TextInformationProvider(
                    label: "課程名稱",
                    information: coursename,
                    labelTexttheme: _theme.textTheme.labelLarge,
                    informationTexttheme: _theme.textTheme.titleLarge,
                    informationTextOverFlow: TextOverflow.visible,
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: TextInformationProvider(
                    label: "上課教室",
                    information: location,
                    labelTexttheme: _theme.textTheme.labelLarge,
                    informationTexttheme: _theme.textTheme.titleLarge,
                    informationTextOverFlow: TextOverflow.visible,
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: TextInformationProvider(
                    label: "授課教師",
                    information: teacher,
                    labelTexttheme: _theme.textTheme.labelLarge,
                    informationTexttheme: _theme.textTheme.titleLarge,
                    informationTextOverFlow: TextOverflow.visible,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(HeroDialogRoute(
                      fullscreenDialog: true,
                      builder: (BuildContext context) {
                        return Center(
                            child: PopupInformationCard(
                          coursename: coursename,
                          teacher: teacher,
                          location: location,
                        ));
                      }));
                },
                child: CourseCard(
                  courseTitle: coursename,
                  informations: [
                    SizedBox(
                      width: 120,
                      child: TextInformationProvider(
                        label: '上課教室',
                        information: location,
                        informationTexttheme: _theme.textTheme.titleLarge,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 140,
                      child: TextInformationProvider(
                        label: '上課時間',
                        information: startTime + ' - ' + endTime,
                        informationTexttheme: _theme.textTheme.titleLarge,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
