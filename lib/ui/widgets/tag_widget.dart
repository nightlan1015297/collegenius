import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final tagHeight = 30.0;
  final String tagText;
  final Color color;

  const Tag({required this.tagText, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tagHeight,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Baseline(
        baseline: tagHeight / 2,
        baselineType: TextBaseline.alphabetic,
        child: Text(tagText,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2),
      ),
    );
  }
}
