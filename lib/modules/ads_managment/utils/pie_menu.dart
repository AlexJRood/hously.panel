import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';
import 'package:hously_flutter/utils/platforms/html_utils_stub.dart'
if (dart.library.html) 'package:hously_flutter/utils/platforms/html_utils_web.dart';








class ActionModel {
  final int id;
  ActionModel({required this.id});
}

List<PieAction> buildPieMenuActions(
    WidgetRef ref, dynamic action, BuildContext context) {

  return [
    
  ];
}

