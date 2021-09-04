import 'package:collegenius/logic/cubit/apptheme_cubit.dart';
import 'package:collegenius/ui/pages/settingpage/setting_section_builder.dart';
import 'package:collegenius/ui/pages/settingpage/basic_setting_tile_widget.dart';
import 'package:collegenius/ui/pages/settingpage/setting_tile_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'io_setting_tile_widget.dart';
import 'optional_setting_tile_widget.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  final title = "設定";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title),
      ),
      body: SettingTileThemeWidget(
        child: Builder(
          builder: (context) {
            final _themeState = context.watch<AppthemeCubit>().state;

            return SingleChildScrollView(
              child: Column(
                children: [
                  SettingSectionWidget(
                      sectionname: "Preference",
                      tiles: <Widget>[
                        OptionalSettingTileWidget(
                          icon: Icons.mode,
                          currentOption: _themeState.darkTheme == true
                              ? "Dark Theme"
                              : "Light Theme",
                          title: "Theme",
                          ontap: () {
                            _themeState.darkTheme == true
                                ? context
                                    .read<AppthemeCubit>()
                                    .changeToLightTheme()
                                : context
                                    .read<AppthemeCubit>()
                                    .changeToDarkTheme();
                          },
                        ),
                      ]),
                  SettingSectionWidget(
                    sectionname: "Example",
                    tiles: <Widget>[
                      OptionalSettingTileWidget(
                          icon: Icons.accessible_sharp,
                          title: "Test",
                          currentOption: "Test",
                          ontap: () {}),
                      OptionalSettingTileWidget(
                          icon: Icons.language,
                          title: "Language",
                          currentOption: "language",
                          ontap: () {}),
                      OptionalSettingTileWidget(
                          icon: Icons.dark_mode,
                          title: "Theme",
                          currentOption: "theme",
                          ontap: () {}),
                      IoSettingTileWidget(
                          icon: Icons.mode,
                          title: "Mode",
                          value: true,
                          ontap: (bool) {}),
                      IoSettingTileWidget(
                          icon: Icons.accessible_sharp,
                          title: "Test",
                          value: true,
                          ontap: (bool) {}),
                      BasicSettingTileWidget(
                          icon: Icons.language,
                          title: "Language",
                          ontap: () {}),
                      BasicSettingTileWidget(
                          icon: Icons.dark_mode, title: "Theme", ontap: () {}),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
