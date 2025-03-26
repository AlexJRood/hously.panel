import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/network_monitoring/state_managers/saved_search/add_client.dart';
import 'package:hously_flutter/network_monitoring/state_managers/saved_search/edit.dart';
import 'package:hously_flutter/network_monitoring/state_managers/saved_search/remove.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:pie_menu/pie_menu.dart';

List<PieAction> buildPieMenuActionsNMsavedSearch(
    WidgetRef ref, dynamic action, dynamic actionId, BuildContext context) {
  return [
    PieAction(
      tooltip: const Text('Usuń zapisane wyszukiwanie'),
      onSelect: () async {
        final confirmed = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Potwierdzenie'),
            content: const Text(
                'Jesteś pewnien że chcesz usunąć zapisane wyszukiwanie?'),
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
          await ref.read(removeSavedSearchProvider).removeSavedSearch(actionId);
        }
      },
      child: const FaIcon(FontAwesomeIcons.trash),
    ),
    PieAction(
      tooltip: const Text('Edytuj ogłoszenie'),
      onSelect: () async {
        print("Editing action with id: $actionId");
        await showEditSavedSearchDialog(context, action, actionId, ref);
      },
      child: const FaIcon(FontAwesomeIcons.edit),
    ),
    PieAction(
      tooltip: const Text('Dodaj klientów'),
      onSelect: () async {
        print("Adding clients to saved search with id: $actionId");
        await addClientsToSavedSearch(context, actionId, ref);
      },
      child: const FaIcon(FontAwesomeIcons.userPlus),
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
