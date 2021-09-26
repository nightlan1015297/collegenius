import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    Text(
                      courseTitle,
                      style: _theme.textTheme.headline5,
                      overflow: TextOverflow.fade,
                    ),
                    Expanded(child: SizedBox()),
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
