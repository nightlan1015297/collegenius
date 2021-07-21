import 'package:collegenius/logic/apptheme_cubit/apptheme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SettingTileThemeWidget extends StatelessWidget {
  final Widget child;
  SettingTileThemeWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    Widget lightTheme = ListTileTheme(
      child: child,
      iconColor: Colors.grey.shade800,
      dense: true,
      style: ListTileStyle.drawer,
    );
    Widget darkTheme = ListTileTheme(
      child: child,
      iconColor: Colors.grey.shade200,
      dense: true,
      style: ListTileStyle.list,
    );
    return Builder(
      builder: (context) {
        final themeState = context.watch<AppthemeCubit>().state;
        return themeState.darkTheme ? darkTheme : lightTheme;
      },
    );
  }
}
