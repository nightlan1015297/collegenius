import 'package:collegenius/logic/apptheme_cubit/apptheme_cubit.dart';
import 'package:collegenius/ui/pages/settingpage/setting_section_builder.dart';
import 'package:collegenius/ui/pages/settingpage/basic_setting_tile_widget.dart';
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
    print('SettingPagebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingSectionWidget(sectionname: "Preference", tiles: <Widget>[
              BlocBuilder<AppthemeCubit, AppthemeState>(
                builder: (context, state) {
                  return OptionalSettingTileWidget(
                    debugprint: "1",
                    icon: Icons.mode,
                    currentoption:
                        state.darkTheme == true ? "Dark Theme" : "Light Theme",
                    title: "Theme",
                    ontap: () {
                      state.darkTheme == true
                          ? context.read<AppthemeCubit>().changeToLightTheme()
                          : context.read<AppthemeCubit>().changeToDarkTheme();
                    },
                  );
                },
              )
            ]),
            SettingSectionWidget(
              sectionname: "Example",
              tiles: <Widget>[
                OptionalSettingTileWidget(
                    debugprint: "2",
                    icon: Icons.accessible_sharp,
                    title: "Test",
                    currentoption: "Test",
                    ontap: () {}),
                OptionalSettingTileWidget(
                    debugprint: "3",
                    icon: Icons.language,
                    title: "language",
                    currentoption: "language",
                    ontap: () {}),
                OptionalSettingTileWidget(
                    debugprint: "4",
                    icon: Icons.dark_mode,
                    title: "theme",
                    currentoption: "theme",
                    ontap: () {}),
                IoSettingTileWidget(
                    icon: Icons.mode,
                    title: "mode",
                    value: true,
                    ontap: (bool) {}),
                IoSettingTileWidget(
                    icon: Icons.accessible_sharp,
                    title: "Test",
                    value: true,
                    ontap: (bool) {}),
                BasicSettingTileWidget(
                    icon: Icons.language, title: "language", ontap: () {}),
                BasicSettingTileWidget(
                    icon: Icons.dark_mode, title: "theme", ontap: () {}),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
