import 'package:flutter/Material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class SchoolTourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PhotoView(
                          imageProvider: AssetImage('images/schoolTour.jpg'),
                        );
                      },
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.info,
                            size: 50,
                            color: _theme.iconTheme.color,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '校園導覽地圖',
                          style: _theme.textTheme.headline6,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 100,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PhotoView(
                          imageProvider:
                              AssetImage('images/schoolBuildingMap.jpg'),
                        );
                      },
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.map,
                            size: 50,
                            color: _theme.iconTheme.color,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '校園建物地圖',
                          style: _theme.textTheme.headline6,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.map,
                        size: 50,
                        color: _theme.iconTheme.color,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '校園建物地圖',
                      style: _theme.textTheme.headline6,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
