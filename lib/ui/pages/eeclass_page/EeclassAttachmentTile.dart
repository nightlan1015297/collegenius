import 'dart:io';

import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EeclassAttachmentTile extends StatelessWidget {
  const EeclassAttachmentTile({Key? key, required this.fileList})
      : super(key: key);
  final List fileList;

  @override
  Widget build(BuildContext context) {
    if (fileList.isEmpty) {
      return SizedBox();
    }
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;

    var _widgetList = <Widget>[];

    _widgetList.add(
      Text(
        _locale.attachments,
        style: _theme.textTheme.bodyLarge,
      ),
    );
    for (var element in fileList) {
      _widgetList.add(
        DownloadAttachmentTags(element: element, theme: _theme),
      );
      if (element != fileList.last) {
        _widgetList.add(Divider());
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _widgetList,
      ),
    );
  }
}

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

    return Row(
      children: [
        Spacer(),
        SizedBox(
          width: 200,
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
            final eeclassRepo = context.read<EeclassRepository>();
            final cookiesString =
                await eeclassRepo.getCookiesStringForDownload();
            await FlutterDownloader.enqueue(
                headers: {
                  HttpHeaders.connectionHeader: 'keep-alive',
                  HttpHeaders.cookieHeader: cookiesString,
                },
                url: 'https://ncueeclass.ncu.edu.tw' + element[1],
                savedDir: "/storage/emulated/0/Download/",
                showNotification: true,
                openFileFromNotification: true,
                saveInPublicStorage: true);
          },
          child: Text(
            _locale.download,
            style: _theme.textTheme.labelLarge,
          ),
        ),
        Spacer()
      ],
    );
  }
}
