import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collegenius/logic/cubit/bottomnav_cubit.dart';

import 'drawer_tile_widget.dart';
import 'navigation_drawer_widget.dart';

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
        appBar: AppBar(
          title: Text(title),
          iconTheme: _theme.iconTheme,
        ),
        drawer: NavigationDrawer(
          tiles: [
            DrawerTile(
              icon: Icons.people,
              title: "People",
              onTap: () {},
            ),
            DrawerTile(
              icon: Icons.settings,
              title: "Setting",
              onTap: () => Navigator.of(context).pushNamed("/setting"),
            ),
          ],
        ),
        body: body,
        bottomNavigationBar: Builder(
          builder: (context) {
            final _bottomnavState = context.watch<BottomnavCubit>().state;

            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _bottomnavState.index,
              backgroundColor: _theme.backgroundColor,
              unselectedIconTheme: _theme.iconTheme,
              selectedIconTheme: IconThemeData(color: Colors.blue),
              selectedFontSize: 12,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                context.read<BottomnavCubit>().changeIndex(index);
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "asd",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "asd",
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
            );
          },
        ));
  }
}
