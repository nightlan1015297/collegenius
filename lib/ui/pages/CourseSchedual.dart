import 'package:collegenius/logic/cubit/coursesection_cubit.dart';
import 'package:collegenius/ui/widgets/information_provider.dart';
import 'package:flutter/material.dart';

import 'package:collegenius/ui/widgets/course_card.dart';
import 'package:collegenius/ui/widgets/node_graph_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseSchedual extends StatelessWidget {
  CourseSchedual({
    Key? key,
    required this.courseList,
  }) : super(key: key);

  final Map<String, Map<String, String?>> courseList;

  String getSectionStartTime(String section) {
    if (section == 'Z') {
      return '12:00';
    }
    if (section == 'A') {
      return '18:00';
    }
    if (section == 'B') {
      return '19:00';
    }
    if (section == 'C') {
      return '20:00';
    }
    if (section == 'D') {
      return '21:00';
    }
    var _hour = int.parse(section) + 8;
    if (_hour < 13) _hour--;
    return '$_hour:00';
  }

  String getSectionEndTime(String section) {
    if (section == 'Z') {
      return '12:50';
    }
    if (section == 'A') {
      return '18:50';
    }
    if (section == 'B') {
      return '19:50';
    }
    if (section == 'C') {
      return '20:50';
    }
    if (section == 'D') {
      return '21:50';
    }
    var _hour = int.parse(section) + 8;
    if (_hour < 13) _hour--;
    return '$_hour:50';
  }

  String _indexToSection(int index) {
    if (index < 4) {
      return (index + 1).toString();
    } else if (index == 4) {
      return 'Z';
    } else if (index < 10) {
      return index.toString();
    } else if (index == 10) {
      return 'A';
    } else if (index == 11) {
      return 'B';
    } else if (index == 12) {
      return 'C';
    } else if (index == 13) {
      return 'D';
    } else {
      throw "Index '$index' out of course section range";
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(2),
                      child: InkWell(
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: _theme.iconTheme.color,
                          size: 30,
                        ),
                        onTap: () {
                          //!TODO
                        },
                      ),
                    ),
                    Text(
                      "Mon",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(2),
                      child: InkWell(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: _theme.iconTheme.color,
                          size: 30,
                        ),
                        onTap: () {
                          //!TODO
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 14,
            itemBuilder: (context, index) {
              final _section = _indexToSection(index);
              final _start = getSectionStartTime(_section);
              final _end = getSectionEndTime(_section);
              final _currentSectionState =
                  context.watch<CoursesectionCubit>().state;

              final _courseName = courseList[_section]!['name'] ?? '空堂';
              final _teacher = courseList[_section]!['teacher'] ?? 'Unknow';
              final _location = courseList[_section]!['location'] ?? 'Unknow';
              final _regularNode = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    TimeLineNode(),
                    TimeLineLine(),
                  ],
                ),
              );

              final _dottedNode = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    TimeLineDottedNode(),
                    TimeLineDottedLine(),
                  ],
                ),
              );

              final _theme = Theme.of(context);
              if (_currentSectionState is CourseSectionLoaded) {
                return LayoutBuilder(builder: (context, constrains) {
                  if (index < _currentSectionState.section) {
                    return Opacity(
                      opacity: 0.3,
                      child: Row(
                        children: [
                          _regularNode,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: constrains.maxWidth - 70,
                              child: CourseCard(
                                courseTitle: _courseName,
                                tags: [
                                  Tag(
                                    color: Colors.grey,
                                    tagText: '課程已結束',
                                  ),
                                  Tag(
                                    color: Colors.blue,
                                    tagText: _start + '~' + _end,
                                  ),
                                ],
                                informations: [
                                  InformationProvider(
                                    label: '上課教室',
                                    information: _location,
                                    informationTexttheme:
                                        _theme.textTheme.headline6,
                                  ),
                                  VerticalSeperater(),
                                  InformationProvider(
                                    label: '授課教師',
                                    information: _teacher,
                                    informationTexttheme:
                                        _theme.textTheme.headline6,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (index == _currentSectionState.section) {
                    return Row(
                      children: [
                        _dottedNode,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: constrains.maxWidth - 70,
                            child: CourseCard(
                              courseTitle: _courseName,
                              tags: [
                                Tag(
                                  color: Colors.green,
                                  tagText: '正在進行',
                                ),
                                Tag(
                                  color: Colors.blue,
                                  tagText: _start + '~' + _end,
                                ),
                              ],
                              informations: [
                                InformationProvider(
                                  label: '上課教室',
                                  information: _location,
                                  informationTexttheme:
                                      _theme.textTheme.headline6,
                                ),
                                VerticalSeperater(),
                                InformationProvider(
                                    label: '授課教師', information: _teacher)
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      _regularNode,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: constrains.maxWidth - 70,
                          child: CourseCard(
                            courseTitle: _courseName,
                            tags: [
                              Tag(
                                color: Colors.blue,
                                tagText: _start + '~' + _end,
                              ),
                            ],
                            informations: [
                              InformationProvider(
                                label: '上課教室',
                                information: _location,
                                informationTexttheme:
                                    _theme.textTheme.headline6,
                              ),
                              VerticalSeperater(),
                              InformationProvider(
                                label: '授課教師',
                                information: _teacher,
                                informationTexttheme:
                                    _theme.textTheme.headline6,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
              }
              return LayoutBuilder(builder: (context, constrains) {
                return Row(
                  children: [
                    _regularNode,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                          width: constrains.maxWidth - 70,
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: constrains.maxWidth - 90,
                              height: 160,
                              child: Center(child: Text('Loading')),
                            ),
                            elevation: 5.0,
                          )),
                    ),
                  ],
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
