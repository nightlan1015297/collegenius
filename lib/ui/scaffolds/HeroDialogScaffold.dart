import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class HeroDialogScaffold extends StatefulWidget {
  const HeroDialogScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<HeroDialogScaffold> createState() => _HeroDialogScaffoldState();
}

class _HeroDialogScaffoldState extends State<HeroDialogScaffold> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      if (data[1] == DownloadTaskStatus.complete) {
        const snackBar = SnackBar(
          content: Text('Download complete.'),
          duration: Duration(milliseconds: 500),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // String id = data[0];
      // DownloadTaskStatus status = data[1];
      // int progress = data[2];
      setState(() {});
    });
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: widget.child,
      ),
    );
  }
}
