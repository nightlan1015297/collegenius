import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/bloc/app_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemePopupSettingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return BlocBuilder<AppSettingBloc, AppSettingState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 230),
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
                              child: Text(_locale.selectSystemTheme,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 8),
                        child: Row(
                          children: [
                            Text(_locale.dark,
                                style: _theme.textTheme.titleLarge),
                            Spacer(),
                            state.themeMode.isDark
                                ? Icon(Icons.check, color: Colors.green)
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<AppSettingBloc>().add(
                            ChangeThemeRequest(themeMode: ThemeMode.light));
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 8),
                        child: Row(
                          children: [
                            Text(_locale.light,
                                style: _theme.textTheme.titleLarge),
                            Spacer(),
                            state.themeMode.isLight
                                ? Icon(Icons.check, color: Colors.green)
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        context.read<AppSettingBloc>().add(
                            ChangeThemeRequest(themeMode: ThemeMode.system));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 8),
                        child: Row(
                          children: [
                            Text(_locale.system,
                                style: _theme.textTheme.headline6),
                            Spacer(),
                            state.themeMode.isSystem
                                ? Icon(Icons.check, color: Colors.green)
                                : SizedBox(),
                          ],
                        ),
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
