import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigationService = Provider((ref) => NavigationService());

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;
  final _prefs = SharedPreferencesAsync();

  set setNavigatorKey(GlobalKey<NavigatorState> key) => navigatorKey = key;

  BuildContext get currentContext => navigatorKey.currentContext!;

  void pushNamedScreen(
      String routeName, {
        Object? data,
      }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentContext.beamToNamed(
        routeName,
        data: data,
      );
    });
  }


  
  void pushNamedReplacementScreen(
      String routeName, {
        Object? data,
      }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentContext.beamToReplacementNamed(
        routeName,
        data: data,
      );
    });
  }


  Future<void> scrollTo({
    required String route,
    ScrollController? controller,
  }) async {
    pushNamedScreen(route);

    if (controller == null || !controller.hasClients) return;
    await Future.delayed(
      Duration.zero,
      () => controller.jumpTo(0),
    );
  }

  void showSnackbar(SnackBar snackbar) {
    ScaffoldMessenger.of(currentContext).clearSnackBars();
    ScaffoldMessenger.of(currentContext).showSnackBar(snackbar);
  }

  void beamPop([dynamic value]) => currentContext.beamBack(data: value);

  void pop([dynamic value]) => Navigator.of(currentContext).pop(value);

  bool canBeamBack() => currentContext.canBeamBack;

  List<BeamPage> currentBeamPages() => currentContext.currentBeamPages;

  List<BeamLocation> beamingHistory() => currentContext.beamingHistory;

  void beamPopName(String url) => currentContext.popToNamed(url);


  void pushNavigator([
  String routeName ='', 
  dynamic value, 
  String? keyTag
  ]) => 
    Navigator.pushNamed(
              currentContext,
              routeName,
              arguments: {
                'tag': keyTag,
                'ad': value
              },
            );
}
