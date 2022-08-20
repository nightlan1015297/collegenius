import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/repositories/school_events_repository.dart';
import 'package:collegenius/routes/hero_dialog_route.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collegenius/logic/cubit/school_events_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SchoolEventPageView extends StatefulWidget {
  @override
  State<SchoolEventPageView> createState() => _SchoolEventPageViewState();
}

class _SchoolEventPageViewState extends State<SchoolEventPageView>
    with AutomaticKeepAliveClientMixin {
  late SchoolEventsCubit _schoolEventsCubit;
  @override
  void initState() {
    super.initState();
    _schoolEventsCubit = SchoolEventsCubit(
      schoolEventsRepository: context.read<SchoolEventsRepository>(),
    );
    _schoolEventsCubit.fetchInitEvents();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _locale = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => _schoolEventsCubit,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: BlocBuilder<SchoolEventsCubit, SchoolEventsState>(
            builder: (context, state) {
          switch (state.status) {
            case SchoolEventsStatus.initial:
            case SchoolEventsStatus.loading:
              return Loading();
            case SchoolEventsStatus.success:
              return Column(
                children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: () =>
                        context.read<SchoolEventsCubit>().fetchInitEvents(),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: state.events.length + 1,
                        itemBuilder: (context, index) {
                          if (index == state.events.length) {
                            context.read<SchoolEventsCubit>().fetchMoreEvents();
                            return Center(child: Loading(size: 60));
                          }
                          var item = state.events[index];

                          return EventCard(
                            category: item.category,
                            group: item.group,
                            time: item.time,
                            title: item.title,
                            url: item.href,
                          );
                        }),
                  )),
                ],
              );
            case SchoolEventsStatus.failure:
              return Center(
                child: Text(_locale.loading),
              );
            case SchoolEventsStatus.loadedend:
              return Column(
                children: [
                  Expanded(
                      child: RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    displacement: 30,
                    onRefresh: () =>
                        context.read<SchoolEventsCubit>().fetchInitEvents(),
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: state.events.length + 1,
                        itemBuilder: (context, index) {
                          if (index == state.events.length) {
                            return SizedBox(
                              height: 100,
                              child: Center(
                                child: Text(_locale.endOfSchoolEvents),
                              ),
                            );
                          }
                          var item = state.events[index];

                          return EventCard(
                              category: item.category,
                              group: item.group,
                              time: item.time,
                              title: item.title,
                              url: item.href);
                        }),
                  )),
                ],
              );
          }
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class EventCard extends StatelessWidget {
  final String? url;
  final String? title;
  final String? category;
  final String? group;
  final String? time;
  const EventCard({
    Key? key,
    this.title,
    this.category,
    this.group,
    this.time,
    this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return InkWell(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                if (url == null) {
                  return Center(child: PopupLoadFailedCard());
                }
                return Center(child: PopupWebViewCard(url: url!));
              }));
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(title ?? _locale.parseError,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: _theme.textTheme.headline6),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Tag(
                          color:
                              mapEventCategoryToColor[category] ?? Colors.grey,
                          tagText: category ?? _locale.parseError,
                        ),
                        ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 0,
                              minWidth: 0,
                              maxHeight: double.infinity,
                              maxWidth: 150,
                            ),
                            child: Tag(
                              color: Colors.grey,
                              tagText: group ?? _locale.parseError,
                            )),
                        Expanded(child: SizedBox()),
                        TextInformationProvider(
                          mainAxisAlignment: MainAxisAlignment.end,
                          information: time ?? _locale.parseError,
                          label: _locale.publicationDate,
                          informationTexttheme: _theme.textTheme.subtitle2,
                        )
                      ],
                    ),
                  ),
                ]),
          )),
        ));
  }
}

class PopupWebViewCard extends StatefulWidget {
  const PopupWebViewCard({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<PopupWebViewCard> createState() => _PopupWebViewCardState();
}

class _PopupWebViewCardState extends State<PopupWebViewCard> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 540, maxHeight: 720),
        child: Card(
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 35,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse(
                            "https://www.ncu.edu.tw/tw/events/" + widget.url)),
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
                    onWebViewCreated: (InAppWebViewController controller) {
                      _webViewController = controller;
                    },
                    onLoadStop: (controller, uri) {
                      _webViewController.evaluateJavascript(source: """
                                document.getElementsByClassName('header')[0].style.display='none';
                                document.getElementsByClassName('inside-page-banner')[0].style.display='none';
                                document.getElementsByClassName('page-bar')[0].style.display='none';
                                document.getElementById('footer clearfix').style.display='none';
                                document.getElementsByClassName('btn_back_wapper')[0].style.display='none';
                                """);
                    },
                    onDownloadStartRequest: (controller, url) async {
                      await FlutterDownloader.enqueue(
                          url: url.url.toString(),
                          savedDir: "/storage/emulated/0/Download/Collegenius",
                          showNotification: true,
                          openFileFromNotification: true,
                          saveInPublicStorage: true);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopupLoadFailedCard extends StatelessWidget {
  const PopupLoadFailedCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: Card(child: Text("-")),
      ),
    );
  }
}
