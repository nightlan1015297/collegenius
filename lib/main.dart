import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:collegenius/constants/maps.dart';
import 'package:collegenius/ui/pages/school_tour_page/SchoolTourPage.dart';
import 'package:collegenius/utilties/PathGenerator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:collegenius/logic/bloc/authentication_bloc.dart' as authBloc;
import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:collegenius/models/course_schedual_model/course_schedual_models.dart';
import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/repositories/portal_repository.dart';
import 'package:collegenius/ui/pages/course_schedual_page/CourseSchedualView.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassCoursesListView.dart';
import 'package:collegenius/ui/pages/school_event_page/SchoolEventPage.dart';
import 'package:collegenius/utilties/AppBlocObserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:collegenius/ui/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/pages/course_schedual_page/CourseSchedualPage.dart';
import 'package:collegenius/ui/theme/AppTheme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'constants/Constants.dart';
import 'firebase_options.dart';
import 'logic/bloc/app_setting_bloc.dart';
import 'logic/cubit/bottomnav_cubit.dart';
import 'repositories/course_schedual_repository.dart';
import 'repositories/school_events_repository.dart';
import 'ui/pages/home_page/HomePageView.dart';
import 'ui/pages/setting_page/SettingPageView.dart';
import 'routes/Routes.dart';

Future<void> main() async {
  final _pathGen = PathGenerator();
  /* ensureInitialized to prevent unpredictable error*/
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await Permission.storage.request();
  await Permission.notification.request();
  await FlutterDownloader.initialize(

      /// optional: set to false to disable printing logs to console (default: true)
      debug: true,
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  /// Using Hive to storage user data
  final hiveDir = await _pathGen.getHiveDatabaseDirectory();
  Hive.init(hiveDir.path);

  /// These Adapter ia all for Course Schedual
  Hive.registerAdapter(SemesterAdapter());
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(CoursePerDayAdapter());
  Hive.registerAdapter(CourseSchedualAdapter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Capture the unhandled crash
  /// The crash will show on crashlytics.
  FlutterError.onError = (detail) {
    FirebaseCrashlytics.instance.recordFlutterError(detail);
    if (kReleaseMode) exit(1);
  };

  /// Using HydratedBloc to storage application state
  /// Hydrated bloc storage application configuration and auth data.
  final storage = await HydratedStorage.build(
    storageDirectory: await PathGenerator().getHydratedBlocDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(Collegenius()),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}

class Collegenius extends StatefulWidget {
  @override
  State<Collegenius> createState() => _CollegeniusState();
}

class _CollegeniusState extends State<Collegenius> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final AppRouter _appRouter = AppRouter();
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // String id = data[0];
      // DownloadTaskStatus status = data[1];
      // int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    if (status == DownloadTaskStatus.complete) {
      const snackBar = SnackBar(
        content: Text('Download complete.'),
        duration: Duration(milliseconds: 500),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (BuildContext context) => EeclassRepository(),
        ),
        RepositoryProvider(
          create: (BuildContext context) => CourseSchedualRepository(),
        ),
        RepositoryProvider(
          create: (BuildContext context) => SchoolEventsRepository(),
        ),
        RepositoryProvider(
          create: (BuildContext context) {
            final _portalRepo = PortalRepository();
            _portalRepo.initializeDio();
            return _portalRepo;
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppSettingBloc>(
            create: (BuildContext context) => AppSettingBloc(),
          ),
          BlocProvider<authBloc.AuthenticationBloc>(
            lazy: false,
            create: (BuildContext context) {
              final authenticationBloc = authBloc.AuthenticationBloc(
                  eeclassRepository: context.read<EeclassRepository>(),
                  courseSchedualRepository:
                      context.read<CourseSchedualRepository>(),
                  portalRepository: context.read<PortalRepository>());
              authenticationBloc.add(authBloc.InitializeRequest());
              return authenticationBloc;
            },
          ),
          BlocProvider<BottomnavCubit>(
            create: (BuildContext context) => BottomnavCubit(),
          ),
          BlocProvider<LoginPageBloc>(
            lazy: false,
            create: (BuildContext context) {
              final loginPageBloc = LoginPageBloc(
                  authenticationBloc:
                      context.read<authBloc.AuthenticationBloc>());
              return loginPageBloc;
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            final _appSetting = context.watch<AppSettingBloc>().state;
            final _bottomNavState = context.watch<BottomnavCubit>().state;

            return MaterialApp(
              title: 'Collegenius',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: _appSetting.themeMode,
              scaffoldMessengerKey: snackbarKey,
              locale: mapAppLanguageToLocal[_appSetting.appLanguage],
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              onGenerateRoute: _appRouter.generateRoute,
              navigatorObservers: [
                FirebaseAnalyticsObserver(
                    analytics: _analytics,
                    nameExtractor: (route) => route.name),
              ],
              home: IconTheme(
                data: _theme.iconTheme,
                child: Builder(builder: (context) {
                  final _locale = AppLocalizations.of(context)!;
                  switch (_bottomNavState.index) {
                    case 0:
                      return MainScaffold(
                        title: _locale.home,
                        body: HomePageView(),
                      );
                    case 1:
                      return MainScaffold(
                        title: _locale.courses,
                        body: CourseSchedualView(
                          courseSchedualRepository:
                              context.read<CourseSchedualRepository>(),
                        ),
                      );
                    case 2:
                      return MainScaffold(
                        title: _locale.eeclass,
                        body: EeclassCoursesListView(),
                      );
                    case 3:
                      return MainScaffold(
                        title: _locale.schoolEvents,
                        body: SchoolEventPageView(),
                      );
                    case 4:
                      return MainScaffold(
                        title: _locale.schoolTour,
                        body: SchoolTourPage(),
                      );
                    case 5:
                      return MainScaffold(
                        title: _locale.setting,
                        body: SettingPageView(),
                      );
                    default:
                      return Center(
                        child: Text(
                            'Route Error : No route defined for bottomNav index ${_bottomNavState.index}'),
                      );
                  }
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
