import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;
  double get buttonBarHeight => MediaQuery.of(this).viewPadding.bottom;
  bool get isDesktop => screenWidth >= 1100;
  bool get isMobile => screenWidth < 650;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  bool get isLargeScreen => screenWidth > 1920;

  Future<dynamic> showPopupMenu({
    required List<PopupMenuEntry<dynamic>> items,
    required RelativeRect relativeRect,
    BoxConstraints? boxConstraints,
  }) async {
    await showMenu(
      context: this,
      position: relativeRect,
      items: items,
      constraints: boxConstraints,
    ).then((value) {
      if (value != null) {
        return value;
      }
    });
  }

  Future<DateTime?> selectDate() => showDatePicker(
        context: this,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

  Future<TimeOfDay?> selectTime() => showTimePicker(
        context: this,
        initialTime: TimeOfDay.now(),
      );
}
// void updateRouteInformation(String route) => Beamer.of(this).update(
//   configuration: RouteInformation(uri: Uri.parse(route)),
//   rebuild: false,
// );
// String? get currentRoute => currentBeamLocation.state.routeInformation.uri.path;
// bool get useMobileLayout => Config.isMobile || ((Config.isWeb || Config.isSubsystem) && (screenWidth <= 650 || !isLandscape));
// AppLocalizations get localization =>
//     AppLocalizations.of(this) ?? AppLocalizationsEn();
