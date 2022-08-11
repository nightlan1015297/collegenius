import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String tagText;
  final Color color;

  const Tag({required this.tagText, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(tagText,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2),
    );
  }
}
