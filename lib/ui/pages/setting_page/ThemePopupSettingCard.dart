import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/bloc/app_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemePopupSettingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return BlocBuilder<AppSettingBloc, AppSettingState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300),
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Stack(
                        children: [
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("選擇主題模式",
                                  style: _theme.textTheme.titleLarge,
                                  textAlign: TextAlign.start),
                            ),
                            alignment: Alignment.center,
                          ),
                          Align(
                            child: IconButton(
                              icon: Icon(Icons.close, size: 30),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        context
                            .read<AppSettingBloc>()
                            .add(ChangeThemeRequest(themeMode: ThemeMode.dark));
                      },
                      child: Row(
                        children: [
                          Text("深色"),
                          state.themeMode.isDark
                              ? Icon(Icons.check, color: Colors.green)
                              : SizedBox(),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<AppSettingBloc>().add(
                            ChangeThemeRequest(themeMode: ThemeMode.light));
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Text("淺色"),
                          state.themeMode.isLight
                              ? Icon(Icons.check, color: Colors.green)
                              : SizedBox(),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        context.read<AppSettingBloc>().add(
                            ChangeThemeRequest(themeMode: ThemeMode.system));
                      },
                      child: Row(
                        children: [
                          Text("系統"),
                          state.themeMode.isSystem
                              ? Icon(Icons.check, color: Colors.green)
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
