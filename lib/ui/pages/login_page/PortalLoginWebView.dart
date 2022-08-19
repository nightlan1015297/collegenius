import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/repositories/portal_repository.dart';
import 'package:collegenius/utilties/ColorfulPrintFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PortalLoginWebView extends StatelessWidget {
  const PortalLoginWebView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late InAppWebViewController _controller;
    return InkWell(
      onTap: () async {
        CookieManager cookieManager = CookieManager.instance();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              final url = Uri.parse('https://portal.ncu.edu.tw/login');
              return InAppWebView(
                initialUrlRequest: URLRequest(
                  url: url,
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
                onWebViewCreated: ((controller) {
                  _controller = controller;
                }),
                onLoadStop: (controller, url) async {
                  if (await _controller.getUrl() ==
                      Uri.parse('https://portal.ncu.edu.tw/')) {
                    final cookies = await cookieManager.getCookies(url: url!);
                    context
                        .read<AuthenticationBloc>()
                        .add(PortalCaptchaAcquiredRequest(cookies:cookies));
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          ),
        );
      },
      child: Icon(
        Icons.manage_accounts,
      ),
    );
  }
}
