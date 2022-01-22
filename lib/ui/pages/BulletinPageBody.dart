import 'package:flutter/material.dart';

class BulletinPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: 100,
                itemExtent: 50,
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                      child: SizedBox(height: 100),
                    ),
                  );
                })),
      ],
    );
  }
}
