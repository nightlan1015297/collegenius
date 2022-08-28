import 'dart:io';

import 'package:collegenius/ui/scaffolds/HeroDialogScaffold.dart';
import 'package:collegenius/utilties/ColorfulPrintFunction.dart';
import 'package:collegenius/utilties/PathGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:collegenius/constants/Constants.dart';

import 'package:collegenius/logic/cubit/eeclass_material_detail_cubit.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'EeclassAttachmentTile.dart';
import 'EeclassOpenInBrowserTag.dart';

class EeclassMaterialPopupDetailCard extends StatefulWidget {
  const EeclassMaterialPopupDetailCard({
    Key? key,
    required this.materialBrief,
  }) : super(key: key);
  final EeclassMaterialBrief materialBrief;
  @override
  State<EeclassMaterialPopupDetailCard> createState() =>
      _EeclassMaterialPopupDetailCardState();
}

class _EeclassMaterialPopupDetailCardState
    extends State<EeclassMaterialPopupDetailCard> {
  late EeclassMaterialDetailCubit eeclassMaterialDetailCubit;

  @override
  void initState() {
    eeclassMaterialDetailCubit = EeclassMaterialDetailCubit(
      eeclassRepository: context.read<EeclassRepository>(),
    );
    eeclassMaterialDetailCubit.onOpenPopupMaterialCardRequest(
      type: widget.materialBrief.type,
      materialUrl: widget.materialBrief.url,
    );
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => eeclassMaterialDetailCubit,
      child:
          BlocBuilder<EeclassMaterialDetailCubit, EeclassMaterialDetailState>(
        builder: (context, state) {
          switch (state.detailCardStatus) {
            case EeclassMaterialDetailCardStatus.loading:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 450, maxHeight: 600),
                      child: Loading(),
                    ),
                  ),
                ),
              );
            case EeclassMaterialDetailCardStatus.success:
              return EeclassMaterialDetailedSuccessCard(
                materialBrief: widget.materialBrief,
                materialDetail: state.materialCardData!,
              );
            case EeclassMaterialDetailCardStatus.failed:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 450, maxHeight: 600),
                      child: Text("Failed"),
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class EeclassMaterialDetailedSuccessCard extends StatelessWidget {
  const EeclassMaterialDetailedSuccessCard(
      {Key? key, required this.materialBrief, required this.materialDetail})
      : super(key: key);
  final EeclassMaterialBrief materialBrief;
  final EeclassMaterial materialDetail;
  Widget _materialBuilder({
    required EeclassMaterial materialDetail,
    required EeclassMaterialBrief materialBrief,
    required BuildContext context,
  }) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;

    var widgetList = <Widget>[
      Row(
        children: [
          Text(
            _locale.content,
            style: _theme.textTheme.labelLarge,
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    ];
    switch (materialBrief.type) {
      case "attachment":
        widgetList.add(
          Text(
            materialDetail.description ?? "",
            style: _theme.textTheme.bodyLarge,
          ),
        );
        widgetList.add(EeclassAttachmentTile(
          fileList: materialDetail.fileList ?? [],
        ));
        break;
      case "pdf":
        widgetList.add(
          DownloadPdfTag(source: materialDetail.source!),
        );

        break;
      case "youtube":
        widgetList.add(
          LaunchYoutubeTag(source: materialDetail.source!),
        );
        break;
    }

    widgetList.add(
      EeclassOpenInBrowserTag(url: materialBrief.url),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: widgetList,
      ),
    );
  }

  Column _materialBriefBuilder(
      {required EeclassMaterialBrief materialBrief,
      required BuildContext context}) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextInformationProvider(
              informationTextOverFlow: TextOverflow.visible,
              informationTexttheme: _theme.textTheme.bodyLarge,
              label: _locale.title,
              information: materialBrief.title),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextInformationProvider(
              label: _locale.readCount,
              informationTexttheme: _theme.textTheme.bodyLarge,
              information: materialBrief.readCount),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextInformationProvider(
              informationTexttheme: _theme.textTheme.bodyLarge,
              label: _locale.auther,
              information: materialBrief.auther),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextInformationProvider(
              informationTexttheme: _theme.textTheme.bodyLarge,
              label: _locale.updateDate,
              information: materialBrief.updateDate),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;

    return HeroDialogScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450, maxHeight: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_locale.materialInformation,
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              _materialBriefBuilder(
                                  materialBrief: materialBrief,
                                  context: context),
                              Divider(),
                              _materialBuilder(
                                context: context,
                                materialBrief: materialBrief,
                                materialDetail: materialDetail,
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DownloadPdfTag extends StatelessWidget {
  const DownloadPdfTag({
    Key? key,
    required this.source,
  }) : super(key: key);
  final String source;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                const snackBar = SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text('Download started!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                final eeclassRepo = context.read<EeclassRepository>();
                final cookiesString =
                    await eeclassRepo.getCookiesStringForDownload();
                final path = await PathGenerator().getDownloadPath();
                await FlutterDownloader.enqueue(
                    headers: {
                      HttpHeaders.connectionHeader: 'keep-alive',
                      HttpHeaders.cookieHeader: cookiesString,
                    },
                    url: 'https://ncueeclass.ncu.edu.tw' + source,
                    savedDir: path,
                    showNotification: true,
                    openFileFromNotification: true,
                    saveInPublicStorage: true);
              },
              child: Text(
                _locale.download,
                style: _theme.textTheme.headline6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LaunchYoutubeTag extends StatelessWidget {
  const LaunchYoutubeTag({
    Key? key,
    required this.source,
  }) : super(key: key);
  final String source;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                final sourceUriString = source;
                final sourceYoutubeUriString =
                    source.replaceFirst(RegExp(r'\https:'), 'youtube:');
                if (Platform.isIOS) {
                  if (await canLaunchUrlString(sourceYoutubeUriString)) {
                    await launchUrlString(sourceYoutubeUriString);
                  } else {
                    if (await canLaunchUrlString(sourceUriString)) {
                      await launchUrlString(sourceUriString);
                    } else {
                      printHighlight("Launch Failed");
                    }
                  }
                } else {
                  if (await canLaunchUrlString(sourceUriString)) {
                    await launchUrlString(
                      sourceUriString,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    printHighlight("Launch Failed");
                  }
                }
              },
              child: Text(
                _locale.openVideo,
                style: _theme.textTheme.headline6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
