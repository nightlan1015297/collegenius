import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  final List<Widget> items;

  CourseList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(children: items),
    );
  }
}

class CourseListTile extends StatelessWidget {
  final courseTitle;
  final List<Widget> tags;

  CourseListTile({
    required this.courseTitle,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
  
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 320,
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    courseTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade ,
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

class Space extends StatelessWidget {
  final double height;
  Space({required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
    );
  }
}
