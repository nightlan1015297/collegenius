import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/bloc/app_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingPageViewState();
}

class SettingPageViewState extends State<SettingPageView> {
  @override
  Widget build(BuildContext context) {
    final _locale = AppLocalizations.of(context)!;
    return Builder(
      builder: (context) {
        return BlocBuilder<AppSettingBloc, AppSettingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SettingSectionWidget(
                      sectionname: _locale.settingPreference,
                      tiles: <Widget>[
                        OptionalSettingTileWidget(
                          icon: Icons.dark_mode,
                          currentOption:
                              mapThememodeToDescription[state.themeMode]!,
                          title: _locale.systemTheme,
                          ontap: () {
                            Navigator.of(context).pushNamed("/setting/theme");
                          },
                        ),
                      ]),
                  SettingSectionWidget(
                      sectionname: _locale.settingLanguage,
                      tiles: <Widget>[
                        OptionalSettingTileWidget(
                          icon: Icons.language,
                          currentOption:
                              mapAppLanguageToDescription[state.appLanguage]!,
                          title: _locale.systemLanguage,
                          ontap: () {
                            Navigator.of(context).pushNamed("/setting/appLang");
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
        );
      },
    );
  }
}

class SettingSectionWidget extends StatelessWidget {
  final String sectionname;
  final List<Widget> tiles;

  SettingSectionWidget({
    required this.sectionname,
    required this.tiles,
  });

  List<Widget> deviderAdder({required List<Widget> tiles}) {
    if (tiles.length == 1) {
      return tiles;
    }
    List<Widget> result = [];
    final Widget seperator = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
    for (int i = 0; i < tiles.length - 1; i++) {
      result.add(tiles[i]);
      result.add(seperator);
    }
    result.add(tiles[tiles.length - 1]);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              sectionname,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Card(
            child: Column(
              children: deviderAdder(tiles: tiles),
            ),
          )
        ],
      ),
    );
  }
}

/*
Basic setting tile widget build the basic tile in setting seection
- setting tile includes Icon , title and decoration in tail of tile
*/

class BasicSettingTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() ontap;

  BasicSettingTileWidget({
    required this.icon,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: _theme.iconTheme.color,
      ),
      title: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: ontap,
    );
  }
}

/*
IO setting tile widget build the I/O binary option tile in setting seection
- IO setting tile includes Icon , title and an I/O in tail of tile
*/
class IoSettingTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final void Function(bool) ontap;

  IoSettingTileWidget({
    required this.icon,
    required this.title,
    required this.value,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return SwitchListTile(
      value: value,
      secondary: Icon(
        icon,
        color: _theme.iconTheme.color,
      ),
      title: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
      onChanged: ontap,
    );
  }
}

/*
Optional setting tile builder build the basic tile in setting seection
- setting tile includes Icon , title and current optional in tail of tile
*/

class OptionalSettingTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String currentOption;

  final void Function() ontap;
  OptionalSettingTileWidget({
    required this.icon,
    required this.currentOption,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: _theme.iconTheme.color,
      ),
      title: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
      trailing: Text(
        currentOption,
        style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
            fontSize: 14),
      ),
      onTap: ontap,
    );
  }
}
