import 'package:collegenius/ui/pages/settingpage/setting_section_builder.dart';
import 'package:collegenius/ui/pages/settingpage/setting_tile_builder.dart';
import 'package:flutter/material.dart';

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
        title: Text(title),
      ),
      body: settingSectionBilder(
        sectionname: "Account",
        tiles: <Widget>[
          settingTileBilder(
              icon: Icons.accessible_sharp, title: "Test", ontap: () {}),
          settingTileBilder(
              icon: Icons.accessible_sharp, title: "Test", ontap: () {}),
          settingTileBilder(
              icon: Icons.accessible_sharp, title: "Test", ontap: () {}),
          settingTileBilder(
              icon: Icons.accessible_sharp, title: "Test", ontap: () {}),
          settingTileBilder(
              icon: Icons.accessible_sharp, title: "Test", ontap: () {}),
          settingTileBilder(
              icon: Icons.accessible_sharp, title: "Test", ontap: () {}),
        ],
      ),
    );
  }
}
