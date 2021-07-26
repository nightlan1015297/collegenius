import 'package:collegenius/ui/pages/course_scheual_page/course_list_widget.dart';
import 'package:collegenius/ui/pages/course_scheual_page/node_graph_widget.dart';
import 'package:flutter/material.dart';

class CourseSchedualBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NodeGraph(),
          CourseList(),
        ],
      ),
    );
  }
}
