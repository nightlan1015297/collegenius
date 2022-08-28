import 'package:collegenius/utilties/PathGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:collegenius/repositories/eeclass_repository.dart';

class EeclassOpenInBrowserTag extends StatelessWidget {
  const EeclassOpenInBrowserTag({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

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
                final eeclassRepo = context.read<EeclassRepository>();
                final cookies = await eeclassRepo.getCookiesListForDownload();
                CookieManager cookieManager = CookieManager.instance();
                for (var cookie in cookies) {
                  cookieManager.setCookie(
                      url: Uri.parse('https://ncueeclass.ncu.edu.tw'),
                      name: cookie.name,
                      value: cookie.value);
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(
                        appBar: AppBar(),
                        body: InAppWebView(
                          initialUrlRequest: URLRequest(
                            url: Uri.parse(
                                'https://ncueeclass.ncu.edu.tw' + url),
                          ),
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
                            ),
                          ),
                          onDownloadStartRequest: (controller, url) async {
                            const snackBar = SnackBar(
                              content: Text('Download started!'),
                              duration: Duration(milliseconds: 500),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            final path =
                                await PathGenerator().getDownloadPath();
                            await FlutterDownloader.enqueue(
                                url: url.url.toString(),
                                savedDir: path,
                                showNotification: true,
                                openFileFromNotification: true,
                                saveInPublicStorage: true);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              child: Text(
                _locale.openInBrowser,
                style: _theme.textTheme.headline6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
