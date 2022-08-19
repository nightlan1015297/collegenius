import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';

class CourseSchedualNotLoginView extends StatelessWidget {
  const CourseSchedualNotLoginView();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                child: Icon(
                  Icons.warning_amber,
                  color: Color.fromARGB(255, 255, 187, 28),
                  size: 120,
                ),
              ),
              CustomPaint(painter: CircleDottedBorderPainter(radius: 70))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "You have to login first to view Course schedual",
              textAlign: TextAlign.center,
              style: _theme.textTheme.bodyLarge,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
            child: Text("Log in"),
          )
        ],
      ),
    );
  }
}
