import 'package:collegenius/ui/pages/home_page/course_status_card.dart';
import 'package:collegenius/ui/pages/home_page/gallery_widget.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';

import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final _vpwidth = constrains.maxWidth;
      if (_vpwidth > 650) {
        return Column(
          children: <Widget>[
            Flexible(
              flex: 2,
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

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    Key? key,
    this.avgTemp,
    this.rainPercentage,
  }) : super(key: key);

  final double? avgTemp;
  final int? rainPercentage;

  @override
  Widget build(BuildContext context) {
    final double _avgTemp = avgTemp ?? 26.0;
    final int _rainPercentage = rainPercentage ?? 50;

    final _theme = Theme.of(context);

    return Card(
      elevation: 5.0,
      color: _theme.cardColor,
      margin: EdgeInsets.all(10.0),
      child: SizedBox(
        height: 160,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '校園天氣',
                    style: _theme.textTheme.titleLarge,
                  ),
                  Expanded(child: SizedBox()),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: _theme.iconTheme.color,
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  InformationProvider(
                    label: '平均氣溫',
                    information: _avgTemp.toString() + '°C',
                  ),
                  VerticalSeperater(),
                  InformationProvider(
                    label: '降雨機率',
                    information: _rainPercentage.toString() + '%',
                  ),
                  VerticalSeperater(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('陣風', style: _theme.textTheme.caption),
                      Icon(
                        Icons.air_outlined,
                        color: _theme.iconTheme.color,
                        size: 26,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
          ]),
        ),
      ),
    );
  }
}
