import 'dart:io';

import 'package:collegenius/utilties/ColorfulPrintFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:collegenius/logic/cubit/eeclass_material_detail_cubit.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EeclassMaterialPopupDetailCard extends StatefulWidget {
  const EeclassMaterialPopupDetailCard({
    Key? key,
    required this.materialBrief,
    required this.heroKey,
  }) : super(key: key);
  final EeclassMaterialBrief materialBrief;
  final UniqueKey heroKey;
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
      child: Hero(
        tag: widget.heroKey,
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
      ),
    );
  }
}

class EeclassMaterialDetailedSuccessCard extends StatefulWidget {
  const EeclassMaterialDetailedSuccessCard(
      {Key? key, required this.materialBrief, required this.materialDetail})
      : super(key: key);
  final EeclassMaterialBrief materialBrief;
  final EeclassMaterial materialDetail;

  @override
  State<EeclassMaterialDetailedSuccessCard> createState() =>
      _EeclassMaterialDetailedSuccessCardState();
}

class _EeclassMaterialDetailedSuccessCardState
    extends State<EeclassMaterialDetailedSuccessCard> {
  Widget _materialBuilder({
    required EeclassMaterial materialDetail,
    required String url,
    required String type,
    required BuildContext context,
  }) {
    final _theme = Theme.of(context);
    var widgetList = <Widget>[
      Row(
        children: [
          Text(
            "內容",
            style: _theme.textTheme.labelLarge,
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    ];
    switch (type) {
      case "attachment":
        widgetList.add(
          Text(
            materialDetail.description ?? "",
            style: _theme.textTheme.bodyLarge,
          ),
        );
        for (var element in materialDetail.fileList ?? []) {
          widgetList.add(
            DownloadAttachmentTags(element: element, theme: _theme),
          );
          if (element != materialDetail.fileList!.last) {
            widgetList.add(Divider());
          }
        }
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
      default:
        widgetList.add(
          OpenInBrowserTag(url: url),
        );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: widgetList,
      ),
    );
  }

  Column _materialBriefBuilder(
      {required Map<String, dynamic> jsonMaterialBrief,
      required BuildContext context}) {
    final _theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextInformationProvider(
              informationTextOverFlow: TextOverflow.visible,
              informationTexttheme: _theme.textTheme.bodyLarge,
              label: "標題",
              information: jsonMaterialBrief["title"] ?? "-"),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextInformationProvider(
              label: "閱讀次數",
              informationTexttheme: _theme.textTheme.bodyLarge,
              information: jsonMaterialBrief["readCount"] ?? "-"),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextInformationProvider(
              informationTexttheme: _theme.textTheme.bodyLarge,
              label: "作者",
              information: jsonMaterialBrief["auther"] ?? "-"),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextInformationProvider(
              informationTexttheme: _theme.textTheme.bodyLarge,
              label: "更新日期",
              information: jsonMaterialBrief["updateDate"] ?? "-"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final jsonMaterialBrief = widget.materialBrief.toJson();
    return Center(
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
                          child: Text("教材資訊",
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
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 550),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: ((context, index) {
                        if (index == 0) {
                          return _materialBriefBuilder(
                              jsonMaterialBrief: jsonMaterialBrief,
                              context: context);
                        } else {
                          return _materialBuilder(
                              context: context,
                              url: widget.materialBrief.url,
                              materialDetail: widget.materialDetail,
                              type: widget.materialBrief.type);
                        }
                      }),
                      separatorBuilder: (context, index) => Divider(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OpenInBrowserTag extends StatelessWidget {
  const OpenInBrowserTag({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                final eeclassRepo = context.read<EeclassRepository>();
                final cookies = await eeclassRepo.getCookiesListForDownload();
                CookieManager cookieManager = CookieManager.instance();
                for (var cookie in cookies) {
                  cookieManager.setCookie(
                      url: Uri.parse('https://ncueeclass.ncu.edu.tw'),
                      name: cookie.name,
                      value: cookie.value);
                }
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse('https://ncueeclass.ncu.edu.tw' + url)),
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          useOnDownloadStart: true,
                          useShouldOverrideUrlLoading: true,
                          mediaPlaybackRequiresUserGesture: false,
                        ),
                        android: AndroidInAppWebViewOptions(
                          useHybridComposition: true,
                        ),
                        ios: IOSInAppWebViewOptions(
                          allowsInlineMediaPlayback: true,
                        )),
                  );
                }));
              },
              child: Text(
                "在瀏覽器中開啟",
                style: _theme.textTheme.headline6,
              ),
            ),
          ),
        ),
      ],
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
            "下載",
            style: _theme.textTheme.labelLarge,
          ),
        ),
        Spacer()
      ],
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                final eeclassRepo = context.read<EeclassRepository>();
                final cookiesString =
                    await eeclassRepo.getCookiesStringForDownload();
                await FlutterDownloader.enqueue(
                    headers: {
                      HttpHeaders.connectionHeader: 'keep-alive',
                      HttpHeaders.cookieHeader: cookiesString,
                    },
                    url: 'https://ncueeclass.ncu.edu.tw' + source,
                    savedDir: "/storage/emulated/0/Download/",
                    showNotification: true,
                    openFileFromNotification: true,
                    saveInPublicStorage: true);
              },
              child: Text(
                "下載",
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
                "開啟影片",
                style: _theme.textTheme.headline6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
