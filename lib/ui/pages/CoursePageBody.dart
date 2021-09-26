import 'package:collegenius/ui/widgets/course_status_card.dart';
import 'package:collegenius/ui/widgets/weather_card.dart';
import 'package:flutter/material.dart';

class CoursePageBody extends StatelessWidget {
  const CoursePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final _vpwidth = constrains.maxWidth;
      final _vpheight = constrains.maxHeight;
      return CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [WeatherCard(), CourseStatusCard()],
            ),
          ),
        ],
      );
    });
  }
}
