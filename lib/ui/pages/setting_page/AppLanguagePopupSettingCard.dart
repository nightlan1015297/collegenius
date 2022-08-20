import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/bloc/app_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLanguagePopupSettingCard extends StatelessWidget {
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
                              child: Text(_locale.selectSystemLanguage,
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
                        context.read<AppSettingBloc>().add(
                              ChangeAppLanguageRequest(lang: Language.zh),
                            );
                      },
                      child: Row(
                        children: [
                          Text(_locale.traditionalChinese,
                              style: _theme.textTheme.headline6),
                          state.appLanguage.isZh
                              ? Icon(Icons.check, color: Colors.green)
                              : SizedBox(),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        context.read<AppSettingBloc>().add(
                              ChangeAppLanguageRequest(lang: Language.en),
                            );
                      },
                      child: Row(
                        children: [
                          Text(_locale.english,
                              style: _theme.textTheme.headline6),
                          state.appLanguage.isEn
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
