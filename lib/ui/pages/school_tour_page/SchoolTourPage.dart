import 'package:flutter/Material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchoolTourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/tour/tourmap');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.info,
                            size: 50,
                            color: _theme.iconTheme.color,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '校園導覽地圖',
                          style: _theme.textTheme.headline6,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 100,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/tour/buildingMap');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.map,
                            size: 50,
                            color: _theme.iconTheme.color,
                          ),
                        ),
                        Spacer(),
                        Text(
                          _locale.schoolBuildingsMap,
                          style: _theme.textTheme.headline6,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              )),
        ),
        // SizedBox(
        //   height: 100,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Card(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 25),
        //         child: Row(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Icon(
        //                 Icons.phone,
        //                 size: 50,
        //                 color: _theme.iconTheme.color,
        //               ),
        //             ),
        //             Spacer(),
        //             Text(
        //               '校園分機表',
        //               style: _theme.textTheme.headline6,
        //             ),
        //             Spacer(),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
