import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/remove_expenses.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:pie_menu/pie_menu.dart';

List<PieAction> pieMenuCrmExpenses(
    WidgetRef ref, dynamic action, dynamic actionId, BuildContext context) {
  return [
    PieAction(
      tooltip: const Text('Usuń przychód'),
      onSelect: () async {
        final confirmed = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Potwierdzenie'),
            content:
                const Text('Jesteś pewnien że chcesz usunąć ten przychód?'),
            actions: [
              TextButton(
                onPressed: () => ref.read(navigationService).beamPop(false),
                child:  Text('Anuluj'.tr),
              ),
              TextButton(
                onPressed: () => ref.read(navigationService).beamPop(true),
                child:  Text('Usuń'.tr),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          await ref.read(removeCrmExpensesProvider).removeCrmExpenses(action);
        }
      },
      child: const FaIcon(FontAwesomeIcons.trash),
    ),
  ];
}

extension ContextExtension on BuildContext {
  void showSnackBarLikeSection(String message) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
