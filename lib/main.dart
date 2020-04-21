//import 'dart:js';

import 'package:daily_buddy_app/app.dart';
import 'package:daily_buddy_app/blocs/blocs.dart';
import 'package:daily_buddy_app/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await flutterLocalNotificationsPlugin.initialize(InitializationSettings(
      AndroidInitializationSettings('app_icon'),
      IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      )));

  await Jiffy.locale("de");

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ActivitiesBloc>(
          lazy: true,
          create: (context) =>
              ActivitiesBloc(activityRepository: InitialActivityRepository())),
      BlocProvider<PreferencesBloc>(
        lazy: false,
        create: (context) => PreferencesBloc(),
      ),
      BlocProvider<DaysBloc>(
        lazy: false,
        create: (context) => DaysBloc(),
      ),
      BlocProvider<TasksBloc>(
        lazy: false,
        create: (context) => TasksBloc(context: context),
      ),
      BlocProvider<NotificationsBloc>(
        lazy: false,
        create: (context) => NotificationsBloc(
            localNotificationsPlugin: flutterLocalNotificationsPlugin,
            context: context),
      ),
      BlocProvider<UserBloc>(
        lazy: false,
        create: (context) => UserBloc(),
      ),
      BlocProvider<QuestionBloc>(
          lazy: false, create: (context) => QuestionBloc())
    ],
    child: DailyBuddyApp(),
  ));
}
