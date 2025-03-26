import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/data/profile/edit_offer/remove_ad_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:pie_menu/pie_menu.dart';

List<PieAction> buildPieMenuYourAds(
    WidgetRef ref, dynamic action, BuildContext context) {
  return [
    PieAction(
      tooltip: const Text('Edit Ad'),
      onSelect: () {
        ref.read(navigationService).pushNamedReplacementScreen(
              '${Routes.editOffer}/${action.id}',
            );
      },
      child: const FaIcon(FontAwesomeIcons.penToSquare),
    ),
    PieAction(
      tooltip: const Text('Usuń ogłoszenie'),
      onSelect: () async {
        final confirmed = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Potwierdzenie'),
            content:
                const Text('Jesteś pewnien że chcesz usunąć to ogłoszenie?'),
            actions: [
              TextButton(
                onPressed: () => ref.read(navigationService).beamPop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => ref.read(navigationService).beamPop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          await ref.read(removeAdProvider).removeAd(action.id);
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
