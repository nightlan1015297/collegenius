import 'package:collegenius/ui/pages/course_scheual_page/course_list_widget.dart';
import 'package:collegenius/ui/pages/course_scheual_page/node_graph_widget.dart';
import 'package:flutter/material.dart';

class CourseSchedualBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NodeGraph(
                      nodes: [
                        Opacity(
                          opacity: 0.3,
                          child: TimeLineNode(),
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: TimeLineLine(),
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: TimeLineNode(),
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: TimeLineLine(),
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: TimeLineNode(),
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: TimeLineLine(),
                        ),
                        TimeLineDottedNode(),
                        TimeLineDottedLine(),
                        TimeLineNode(),
                        TimeLineLine(),
                      ],
                    ),
                    CourseList(
                      items: [
                        Opacity(
                          opacity: 0.3,
                          child: CourseListTile(
                            courseTitle: "實驗物理 (A)",
                            tags: [
                              Tag(
                                tagText: "7:10 - 8:00",
                                color: Colors.blue,
                              ),
                              Tag(
                                tagText: "已結束",
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        Space(height: 10),
                        Opacity(
                          opacity: 0.3,
                          child: CourseListTile(
                            courseTitle: "基礎微積分 II",
                            tags: [
                              Tag(
                                tagText: "8:10 - 9:00",
                                color: Colors.blue,
                              ),
                              Tag(
                                tagText: "已結束",
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        Space(height: 10),
                        Opacity(
                          opacity: 0.3,
                          child: CourseListTile(
                            courseTitle: "高等工程數學",
                            tags: [
                              Tag(
                                tagText: "8:10 - 9:00",
                                color: Colors.blue,
                              ),
                              Tag(
                                tagText: "已結束",
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        Space(height: 10),
                        CourseListTile(courseTitle: "同步輻射與中子散射的基礎與應用", tags: [
                          Tag(
                            tagText: "10:10 - 11:00",
                            color: Colors.blue,
                          ),
                          Tag(
                            tagText: "正在進行",
                            color: Colors.green,
                          )
                        ]),
                        Space(height: 10),
                        CourseListTile(courseTitle: "同步輻射與中子散射的基礎與應用", tags: [
                          Tag(
                            tagText: "11:10 - 12:00",
                            color: Colors.blue,
                          ),
                          Tag(
                            tagText: "12小時36分鐘後開始",
                            color: Colors.red,
                          )
                        ]),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
