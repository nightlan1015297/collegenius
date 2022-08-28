import 'package:collegenius/ui/pages/eeclass_page/DownloadAttachmentTags.dart';
import 'package:flutter/Material.dart';
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
