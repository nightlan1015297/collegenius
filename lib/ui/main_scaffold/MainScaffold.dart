import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collegenius/logic/cubit/bottomnav_cubit.dart';

//import 'drawer_tile_widget.dart';
//import 'navigation_drawer_widget.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  MainScaffold({
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
            title: Text(
              title,
              style: _theme.textTheme.titleLarge,
            ),
            elevation: 0,
            iconTheme: _theme.iconTheme,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.person,
                ),
                onPressed: () => Navigator.pushNamed(context, '/login'),
              )
            ]),
        body: body,
        bottomNavigationBar: Builder(
          builder: (context) {
            final _bottomnavState = context.watch<BottomnavCubit>().state;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _bottomnavState.index,
                  unselectedIconTheme: _theme.iconTheme,
                  selectedIconTheme: IconThemeData(color: Colors.blue),
                  selectedFontSize: 12,
                  /*Setting unselectedFontSize to zero to fix Framework Unhandled error
                    See issue :https://github.com/flutter/flutter/issues/86545
                  */
                  unselectedFontSize: 0.0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: (index) {
                    context.read<BottomnavCubit>().changeIndex(index);
                  },
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      activeIcon: Icon(Icons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.feed,
                      ),
                      label: "news",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.auto_stories,
                      ),
                      label: "Courses",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.business),
                      label: "asd",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.school),
                      label: "asd",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: "asd",
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
