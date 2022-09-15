import 'package:convida/app/screens/alter_event_screen/alter_event_widget.dart';
import 'package:convida/app/screens/list_admins_screen/list_widget.dart';
import 'package:convida/app/screens/recovery_screen/recovery_widget.dart';
import 'package:convida/app/screens/report_screen/report_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:convida/app/screens/main_screen/main_widget.dart';
import 'package:convida/app/screens/signup_screen/signup_widget.dart';
import 'package:convida/app/screens/map_screen/map_widget.dart';
import 'package:convida/app/screens/search_screen/search_widget.dart';
import 'package:convida/app/screens/login_screen/login_widget.dart';
import 'package:convida/app/screens/detailed_event_screen/detailed_event_widget.dart';
import 'package:convida/app/screens/map_event_screen/map_event_screen_widget.dart';
import 'package:convida/app/screens/new_event_screen/new_event_widget.dart';
import 'package:convida/app/screens/my_events_screen/my_events_widget.dart';
import 'package:convida/app/screens/my_detailed_event_screen/my_detailed_event_widget.dart';
import 'package:convida/app/screens/about_screen/about_widget.dart';

var routes = <String, WidgetBuilder>{
  //'/': (context) => SplashScreen(),
  '/main': (context) => MainWidget(),
  '/map': (context) => MapWidget(),
  '/login': (context) => LoginWidget(),
  '/signup': (context) => SignUpWidget(),
  '/event': (context) => DetailedEventWidget(),
  '/event-map': (context) => MapEventWidget(),
  '/new-event': (context) => NewEventWidget(),
  '/my-events': (context) => MyEventsWidget(),
  '/my-detailed-event': (context) => MyDetailedEventWidget(),
  '/search': (context) => SearchWidget(),
  '/about': (context) => AboutWidget(),
  '/report': (context) => ReportWidget(),
  '/list-admin': (context) => ListAdminWidget(),
  '/recovery': (context) => RecoveryWidget(),
  //'/organization' : (context) => OrganizationWidget()
  //'/alter-event' : (context) => AlterEventWidget(event: evente,
};
