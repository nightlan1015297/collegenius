import 'package:collegenius/ui/widgets/course_status_card.dart';
import 'package:collegenius/ui/widgets/gallery_widget.dart';
import 'package:collegenius/ui/widgets/weather_card.dart';
import 'package:flutter/material.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final _vpwidth = constrains.maxWidth;
      final _vpheight = constrains.maxHeight;
      if (_vpwidth > 650) {
        return Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Gallery(
                height: _vpheight * 0.3,
                children: [
                  GalleryPage(),
                  GalleryPage(),
                  GalleryPage(),
                  GalleryPage(),
                  GalleryPage(),
                  GalleryPage(),
                  GalleryPage(),
                  GalleryPage()
                ],
              ),
            ),
            Flexible(
              flex: 6,
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    SizedBox(width: _vpwidth / 2, child: WeatherCard()),
                    SizedBox(width: _vpwidth / 2, child: CourseStatusCard()),
                  ],
                ),
              ),
            )
          ],
        );
      }
      return Column(
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Gallery(
              children: [
                GalleryPage(),
                GalleryPage(),
                GalleryPage(),
                GalleryPage(),
                GalleryPage(),
                GalleryPage(),
                GalleryPage(),
                GalleryPage()
              ],
            ),
          ),
          Flexible(
            flex: 6,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  WeatherCard(),
                  CourseStatusCard(),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
