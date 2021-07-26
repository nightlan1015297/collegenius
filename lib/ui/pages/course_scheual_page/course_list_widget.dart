import 'package:collegenius/ui/pages/course_scheual_page/spacer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          CourseListTile(
            courseTitle: "同步輻射與中子散射的基礎與應用",
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
          Space(height: 10),
          CourseListTile(
            courseTitle: "同步輻射與中子散射的基礎與應用",
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
          Space(height: 10),
          CourseListTile(
            courseTitle: "同步輻射與中子散射的基礎與應用",
            tags: [
              Tag(
                tagText: "9:10 - 10:00",
                color: Colors.blue,
              ),
              Tag(
                tagText: "已結束",
                color: Colors.grey,
              )
            ],
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
    );
  }
}

class CourseListTile extends StatelessWidget {
  String courseTitle;
  final List<Widget> tags;

  CourseListTile({
    required this.courseTitle,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    if (courseTitle.length > 13) {
      courseTitle = courseTitle.substring(0, 14);
      courseTitle += "..";
    }

    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 320,
        height: 126,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  courseTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(children: tags)
          ],
        ),
      ),
      elevation: 5.0,
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
