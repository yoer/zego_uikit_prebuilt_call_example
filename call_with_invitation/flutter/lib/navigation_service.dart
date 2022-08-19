// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

/// void main() {
///   /// 1. init navigation service before run app
///   NavigationService().init();
///
///   runApp(const MyApp());
/// }
///
/// class MyApp extends StatelessWidget {
///   const MyApp({Key? key}) : super(key: key);
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       /// 2. register app navigator key
///       navigatorKey: locator<NavigationService>().navigatorKey,
///     );
///   }
/// }
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void init() {
    locator.registerLazySingleton(() => NavigationService());
  }
}
