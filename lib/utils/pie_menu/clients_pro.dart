import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/statuses_clients/contact_status_list.dart';
import 'package:pie_menu/pie_menu.dart';

List<PieAction> buildPieMenuActionsClientsPro(
    WidgetRef ref, dynamic action, dynamic actionId, BuildContext context) {
  return [


    PieAction(
      tooltip: const Text('Archiwizuj klienta'),
      onSelect: () async {
        final confirmed = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Potwierdzenie'),
            content: const Text(
                'Jesteś pewnien że chcesz zarchiwizować tego klienta?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child:  Text('Anuluj'.tr),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();  
                   ref.read(clientProvider.notifier).deleteClient(action);
                },
                child:  Text('Usuń'.tr),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          await ref.read(clientProvider.notifier).deleteClient(action);
          // await ref.read(removeSavedSearchProvider).removeSavedSearch(action);
        }
      },
      child: const FaIcon(FontAwesomeIcons.trash),
    ),




    PieAction(
      tooltip: const Text('Statusy'),
      onSelect: () async {   
        Navigator.of(context).push(      
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => UserContactStatusPopUp(isFilter: true),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(opacity: anim, child: child);
            },
          ),
        );
      },
      child: const FaIcon(FontAwesomeIcons.filter),
    ),


    PieAction(
      tooltip: const Text('Zmień status klienta'),
      onSelect: () async {        
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => UserContactStatusPopUp(contact: actionId, isFilter: false,),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(opacity: anim, child: child);
            },
          ),
        );
      },
      child: const FaIcon(FontAwesomeIcons.sync),
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