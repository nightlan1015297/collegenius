import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:io';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/utilties/PathGenerator.dart';

class DownloadAttachmentTags extends StatelessWidget {
  const DownloadAttachmentTags({
    Key? key,
    required this.element,
    required ThemeData theme,
  })  : _theme = theme,
        super(key: key);

  final List element;
  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    final _locale = AppLocalizations.of(context)!;

    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Spacer(),
          SizedBox(
            width: constraints.maxWidth - 125,
            child: Text(
              element[0] ?? "",
              style: _theme.textTheme.bodyLarge,
              overflow: TextOverflow.visible,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              const snackBar = SnackBar(
                content: Text('Download started!'),
                duration: Duration(milliseconds: 500),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              final eeclassRepo = context.read<EeclassRepository>();
              final cookiesString =
                  await eeclassRepo.getCookiesStringForDownload();
              final path = await PathGenerator().getDownloadPath();
              final taskId = await FlutterDownloader.enqueue(
                  headers: {
                    HttpHeaders.connectionHeader: 'keep-alive',
                    HttpHeaders.cookieHeader: cookiesString,
                  },
                  url: 'https://ncueeclass.ncu.edu.tw' + element[1],
                  savedDir: path,
                  showNotification: true,
                  openFileFromNotification: true,
                  saveInPublicStorage: true);
            },
            child: Text(
              _locale.download,
              style: _theme.textTheme.labelLarge,
            ),
          ),
          Spacer(),
        ],
      );
    });
  }
}
