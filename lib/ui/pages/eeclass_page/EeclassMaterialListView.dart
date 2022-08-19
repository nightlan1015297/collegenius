import 'package:collegenius/routes/hero_dialog_route.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'EeclassMaterialPopupDetailCard.dart';

class EeclassMaterialListView extends StatelessWidget {
  final List<EeclassMaterialBrief> materialList;
  const EeclassMaterialListView({
    Key? key,
    required this.materialList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Material overview",
          style: _theme.textTheme.titleLarge,
        ),
        elevation: 0,
        iconTheme: _theme.iconTheme,
        backgroundColor: _theme.scaffoldBackgroundColor,
      ),
      body: Builder(builder: (context) {
        if (materialList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: materialList.length,
              itemBuilder: (context, index) {
                final materialInfoBrief = materialList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      EeclassMaterialCard(materialInfoBrief: materialInfoBrief),
                );
              },
            ),
          );
        } else
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _locale.noDataEmoticon,
                      style: _theme.textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w900),
                    )
                  ]),
              Text(_locale.noData),
            ],
          );
      }),
    );
  }
}

class EeclassMaterialCard extends StatelessWidget {
  EeclassMaterialCard({
    required this.materialInfoBrief,
  });

  final EeclassMaterialBrief materialInfoBrief;
  final Map<String, IconData> mapMaterialTypeToIcon = {
    "attachment": Icons.attach_file,
    "pdf": Icons.picture_as_pdf,
    "youtube": Icons.video_label,
  };
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constrains) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              HeroDialogRoute(
                builder: (context) {
                  return EeclassMaterialPopupDetailCard(
                    materialBrief: materialInfoBrief,
                  );
                },
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.all(10),
              width: constrains.maxWidth - 20,
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          materialInfoBrief.title,
                          style: _theme.textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: _theme.iconTheme.color,
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(children: [
                      SizedBox(
                        child: TextInformationProvider(
                            informationTextOverFlow: TextOverflow.ellipsis,
                            label: _locale.uploadDate,
                            information: materialInfoBrief.updateDate),
                      ),
                      VerticalSeperater(),
                      SizedBox(
                        width: 50,
                        child: IconInformationProvider(
                          informationIcon: Icon(
                              mapMaterialTypeToIcon[materialInfoBrief.type] ??
                                  Icons.help),
                          label: _locale.type,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 80,
                        child: TextInformationProvider(
                            informationTextOverFlow: TextOverflow.ellipsis,
                            label: _locale.auther,
                            information: materialInfoBrief.auther),
                      ),
                    ]),
                  )
                ],
              ),
            ),
            elevation: 5.0,
          ),
        );
      },
    );
  }
}
