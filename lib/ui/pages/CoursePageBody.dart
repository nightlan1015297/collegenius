import 'package:collegenius/ui/widgets/course_status_card.dart';
import 'package:collegenius/ui/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:school_information_api/school_information_api.dart';

class CoursePageBody extends StatelessWidget {
  const CoursePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchoolInformationApiClient().getEvents(1);
    return LayoutBuilder(builder: (context, constrains) {
      // final _vpwidth = constrains.maxWidth;
      // final _vpheight = constrains.maxHeight;

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
