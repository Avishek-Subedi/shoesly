import 'package:shoesly/config/route/route_model.dart';

/// [Paths] list of all routes
class Paths {
  static final RouteModel appStateObserver =
      RouteModel(routeName: 'appStateObserver', path: '/appStateObserver');

  // welcomeScreen

  static final RouteModel welcomeScreenRoute =
      RouteModel(routeName: 'welcomeScreenRoute', path: '/welcomeScreenRoute');

  static final RouteModel loginScreenRoute =
      RouteModel(routeName: 'loginScreenRoute', path: '/loginScreenRoute');

  static final RouteModel signupScreenRoute =
      RouteModel(routeName: 'signupScreenRoute', path: '/signupScreenRoute');
  static final RouteModel homeScreenRoute =
      RouteModel(routeName: 'homeScreenRoute', path: '/homeScreenRoute');
}
