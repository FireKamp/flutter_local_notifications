import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/screens/board/board_screen.dart';
import 'package:sudoku_brain/screens/board/main_board_bloc.dart';
import 'package:sudoku_brain/screens/gameend/bloc.dart';
import 'package:sudoku_brain/screens/gameend/gameend_screen.dart';
import 'package:sudoku_brain/screens/help/bloc.dart';
import 'package:sudoku_brain/screens/help/help_screen.dart';
import 'package:sudoku_brain/screens/home/bloc.dart';
import 'package:sudoku_brain/screens/home/home_screen.dart';
import 'package:sudoku_brain/screens/level/bloc.dart';
import 'package:sudoku_brain/screens/level/level_screen.dart';
import 'package:sudoku_brain/screens/levelselection/levelselection_bloc.dart';
import 'package:sudoku_brain/screens/levelselection/levelselection_screen.dart';
import 'package:sudoku_brain/screens/notifications/dayselection/dayselection_screen.dart';
import 'package:sudoku_brain/screens/notifications/dayselection/notidayselection_bloc.dart';
import 'package:sudoku_brain/screens/notifications/notificationpermission/bloc.dart';
import 'package:sudoku_brain/screens/notifications/notificationpermission/notification_permission_screen.dart';
import 'package:sudoku_brain/screens/notifications/notificationsettings/bloc.dart';
import 'package:sudoku_brain/screens/notifications/notificationsettings/notification_settings_screen.dart';
import 'package:sudoku_brain/screens/notifications/timeselection/bloc.dart';
import 'package:sudoku_brain/screens/notifications/timeselection/notificatio_time_selection_screen.dart';
import 'package:sudoku_brain/screens/settings/bloc.dart';
import 'package:sudoku_brain/screens/settings/settings_screen.dart';
import 'package:sudoku_brain/screens/splash/bloc.dart';
import 'package:sudoku_brain/screens/splash/splash_screen.dart';
import 'package:sudoku_brain/screens/tutorial/bloc.dart';
import 'package:sudoku_brain/screens/tutorial/tutorial_screen.dart';
import 'package:sudoku_brain/utils/Constants.dart';

void main() {
  if (kReleaseMode) {
    runZoned(() {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
            (_) => runApp(MyApp()),
      );
    }, onError: Crashlytics.instance.recordError);
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '',
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => BlocProvider<SplashBloc>(
              create: (BuildContext context) => SplashBloc(),
              child: SplashScreen(),
            ),
        HomeScreen.id: (context) => BlocProvider<HomeBloc>(
              create: (BuildContext context) => HomeBloc(),
              child: HomeScreen(),
            ),
        MainBoard.id: (context) => BlocProvider<MainBoardBloc>(
              create: (BuildContext context) => MainBoardBloc(),
              child: MainBoard(),
            ),
        LevelScreen.id: (context) => BlocProvider<LevelBloc>(
              create: (BuildContext context) => LevelBloc(),
              child: LevelScreen(),
            ),
        HelpScreen.id: (context) => BlocProvider<HelpBloc>(
              create: (BuildContext context) => HelpBloc(),
              child: HelpScreen(),
            ),
        TutorialScreen.id: (context) => BlocProvider<TutorialBloc>(
              create: (BuildContext context) => TutorialBloc(),
              child: TutorialScreen(),
            ),
        SettingsScreen.id: (context) => BlocProvider<SettingsBloc>(
              create: (BuildContext context) => SettingsBloc(),
              child: SettingsScreen(),
            ),
        GameEndScreen.id: (context) => BlocProvider<GameendBloc>(
              create: (BuildContext context) => GameendBloc(),
              child: GameEndScreen(),
            ),
        LevelSelection.id: (context) => BlocProvider<LevelSelectionBloc>(
              create: (BuildContext context) => LevelSelectionBloc(),
              child: LevelSelection(),
            ),
        NotificationTimeSelection.id: (context) =>
            BlocProvider<NotificationTimeSelectionBloc>(
              create: (BuildContext context) => NotificationTimeSelectionBloc(),
              child: NotificationTimeSelection(),
            ),
        NotificationsSettingsScreen.id: (context) =>
            BlocProvider<NotificationSettingBloc>(
              create: (BuildContext context) => NotificationSettingBloc(),
              child: NotificationsSettingsScreen(),
            ),
        DaySelectionScreen.id: (context) => BlocProvider<NotidayselectionBloc>(
              create: (BuildContext context) => NotidayselectionBloc(),
              child: DaySelectionScreen(),
            ),
        NotificationPermission.id: (context) =>
            BlocProvider<NotificationPermissionBloc>(
              create: (BuildContext context) => NotificationPermissionBloc(),
              child: NotificationPermission(),
            ),
      },
    );
  }
}
