import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/network_monitoring/components/cards/va.dart';
import 'package:hously_flutter/network_monitoring/components/cards/v.dart';
import 'package:hously_flutter/network_monitoring/components/cards/a.dart';


enum CardTypeNM {
  alex,
  victoria,
  vanda,
}


extension CardTypeExtensionNM on CardTypeNM {
  /// Różne aspectRatio w zależności od typu karty.
  double get aspectRatio {
    switch (this) {
      case CardTypeNM.alex:
        return 1.0;
      case CardTypeNM.victoria:
        // Karty Victoria szersze np. o 50%
        return 1;
      case CardTypeNM.vanda:
        // Karty Victoria szersze np. o 50%
        return 1;
    }
  }

  /// Bazowa szerokość używana w obliczeniach liczby kolumn.
  /// Dla Victorii może być większa (np. +50%).
  double get baseWidth {
    switch (this) {
      case CardTypeNM.alex:
        return 500;
      case CardTypeNM.victoria:
        return 750; // 500 x 1.5
      case CardTypeNM.vanda:
        return 750; // 500 x 1.5
    }
  }

  double get basePadding {
    switch (this) {
      case CardTypeNM.alex:
        return 8;
      case CardTypeNM.victoria:
        return 25; 
      case CardTypeNM.vanda:
        return 10; 
    }
  }
    double get mapAspectRatio {
    switch (this) {
      case CardTypeNM.alex:
        return 16/9;
      case CardTypeNM.victoria:
        return 16/10; 
      case CardTypeNM.vanda:
        return 16/11; 
    }
  }
    double get gridRowCount {
    switch (this) {
      case CardTypeNM.alex:
        return 1;
      case CardTypeNM.victoria:
        return 2; 
      case CardTypeNM.vanda:
        return 2; 
    }
  }
}


final selectedCardProviderNM = StateProvider<CardTypeNM>((ref) {
  return CardTypeNM.vanda; // domyślnie Alex
});




class SelectedCardWidgetNM extends ConsumerWidget {
  final dynamic ad;
  final String tag;
  final String mainImageUrl;
  final bool isPro;
  final bool isDefaultDarkSystem;
  final Color color;
  final Color textColor;
  final Color textFieldColor;
  final Widget buildShimmerPlaceholder;
  final buildPieMenuActions;
  final double aspectRatio;
  final bool isMobile;

  const SelectedCardWidgetNM({
    Key? key,
    required this.ad,
    required this.tag,
    required this.mainImageUrl,
    required this.isPro,
    required this.isDefaultDarkSystem,
    required this.color,
    required this.textColor,
    required this.textFieldColor,
    required this.buildShimmerPlaceholder,
    required this.buildPieMenuActions,
    required this.aspectRatio,    
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardType = ref.watch(selectedCardProviderNM);

    switch (cardType) {
      case CardTypeNM.alex:
        return NetworkMonitoringAlexCardWidget(
          isMobile: isMobile,
          aspectRatio: aspectRatio,
          ad: ad,
          tag: tag,
          mainImageUrl: mainImageUrl,
          isPro: isPro,
          isDefaultDarkSystem: isDefaultDarkSystem,
          color: color,
          textColor: textColor,
          textFieldColor: textFieldColor,
          buildShimmerPlaceholder: buildShimmerPlaceholder,
          buildPieMenuActions: buildPieMenuActions,
        );
      case CardTypeNM.victoria:
        return NetworkMonitoringVictoriaCardWidget(
          isMobile: isMobile,
          aspectRatio: aspectRatio,
          ad: ad,
          tag: tag,
          mainImageUrl: mainImageUrl,
          isPro: isPro,
          isDefaultDarkSystem: isDefaultDarkSystem,
          color: color,
          textColor: textColor,
          textFieldColor: textFieldColor,
          buildShimmerPlaceholder: buildShimmerPlaceholder,
          buildPieMenuActions: buildPieMenuActions,
        );
      case CardTypeNM.vanda:
        return NetworMonitoringCardVandA(
          isMobile: isMobile,
          aspectRatio: aspectRatio,
          ad: ad,
          tag: tag,
          mainImageUrl: mainImageUrl,
          isPro: isPro,
          isDefaultDarkSystem: isDefaultDarkSystem,
          color: color,
          textColor: textColor,
          textFieldColor: textFieldColor,
          buildShimmerPlaceholder: buildShimmerPlaceholder,
          buildPieMenuActions: buildPieMenuActions,
        );
    }
  }
}
