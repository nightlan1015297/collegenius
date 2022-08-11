import 'package:collegenius/routes/hero_dialog_route.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collegenius/logic/cubit/school_events_cubit.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Map<String, Color> eventCategoryToColor = {
  '行政': Color.fromARGB(255, 100, 193, 236),
  '活動': Color.fromARGB(255, 191, 244, 130),
  '徵才': Color.fromARGB(255, 236, 130, 255),
  '演講': Color.fromARGB(255, 244, 189, 108),
  '施工': Color.fromARGB(255, 255, 152, 186)
};

class BulletinHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Builder(builder: (context) {
        var _schoolEventsState = context.watch<SchoolEventsCubit>().state;
        switch (_schoolEventsState.status) {
          case SchoolEventsStatus.initial:
            context.read<SchoolEventsCubit>().fetchInitEvents();
            return Loading(size: 80);
          case SchoolEventsStatus.loading:
            return Loading(size: 80);
          case SchoolEventsStatus.success:
            return Column(
              children: [
                Expanded(
                    child: RefreshIndicator(
                  onRefresh: () =>
                      context.read<SchoolEventsCubit>().fetchInitEvents(),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _schoolEventsState.events.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _schoolEventsState.events.length) {
                          context.read<SchoolEventsCubit>().fetchMoreEvents();
                          return Center(child: Loading(size: 60));
                        }
                        var item = _schoolEventsState.events[index];

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
              child: Text('Loading'),
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
                      itemCount: _schoolEventsState.events.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _schoolEventsState.events.length) {
                          return SizedBox(
                              height: 30,
                              child: Center(child: Text('End of bulletin')));
                        }
                        var item = _schoolEventsState.events[index];

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
    );
  }
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
    var _theme = Theme.of(context);

    return GestureDetector(
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
                    child: Text(title ?? 'Load Failed',
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
                          color: eventCategoryToColor[category] ?? Colors.grey,
                          tagText: category ?? 'Load Failed',
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
                              tagText: group ?? 'Load Failed',
                            )),
                        Expanded(child: SizedBox()),
                        TextInformationProvider(
                          mainAxisAlignment: MainAxisAlignment.end,
                          information: time ?? 'Load Failed',
                          label: '發布日期',
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
                          savedDir: "/storage/emulated/0/Download/",
                          showNotification:
                              true, // show download progress in status bar (for Android)
                          openFileFromNotification:
                              true, // click on notification to open downloaded file (for Android)
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

// WebView(
//                     javascriptMode: JavascriptMode.unrestricted,
//                     initialUrl:
//                         "https://www.ncu.edu.tw/tw/events/" + widget.url,
//                     onWebViewCreated: (controller) {
//                       this.controller = controller;
//                     },
//                     onPageFinished: (_) {
//                       controller.runJavascript(
//                           "document.getElementsByClassName('header')[0].style.display='none'");
//                       controller.runJavascript(
//                           "document.getElementsByClassName('inside-page-banner')[0].style.display='none'");
//                       controller.runJavascript(
//                           "document.getElementsByClassName('page-bar')[0].style.display='none'");
//                       controller.runJavascript(
//                           "document.getElementById('footer clearfix').style.display='none'");
//                       controller.runJavascript(
//                           "document.getElementsByClassName('btn_back_wapper')[0].style.display='none'");
//                     }),
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
        child: Card(child: Text("Load Failed")),
      ),
    );
  }
}
