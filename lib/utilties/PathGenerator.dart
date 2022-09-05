import 'dart:io';

import 'package:path_provider/path_provider.dart';

class UnableToGetDirectory implements Exception {}

class PathGenerator {
  Future<String> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
        final savePath = directory.path + '/Downloads';
        final savedDir = Directory(savePath);
        bool hasExisted = await savedDir.exists();
        if (!hasExisted) {
          savedDir.create();
        }
        return savedDir.path;
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
        final savePath = directory!.path + '/Collegenius';
        final savedDir = Directory(savePath);
        bool hasExisted = await savedDir.exists();
        if (!hasExisted) {
          savedDir.create();
        }
        return savedDir.path;
      }

      /// ignore: unused_catch_stack
    } catch (err, stacktrace) {
      throw UnableToGetDirectory();
    }
  }

  Future<String> getAppLibraryPath() async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  Future<Directory> getHydratedBlocDirectory() async {
    final applib = await getAppLibraryPath();
    final resultDir = Directory(applib + 'HydratedBloc');
    bool hasExisted = await resultDir.exists();
    if (!hasExisted) {
      resultDir.create();
    }
    return resultDir;
  }

  Future<Directory> getHiveDatabaseDirectory() async {
    final applib = await getAppLibraryPath();
    final resultDir = Directory(applib + 'HiveDatabase');
    bool hasExisted = await resultDir.exists();
    if (!hasExisted) {
      resultDir.create();
    }
    return resultDir;
  }
}
