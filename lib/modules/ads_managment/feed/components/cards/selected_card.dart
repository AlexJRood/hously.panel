import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/ads_managment/feed/components/cards/a.dart';
import 'package:hously_flutter/modules/ads_managment/feed/components/cards/v.dart';
import 'package:hously_flutter/modules/ads_managment/feed/components/cards/va.dart';


enum CardType {
  alex,
  victoria,
  vanda,
}


extension CardTypeExtension on CardType {
  /// Różne aspectRatio w zależności od typu karty.
  double get aspectRatio {
    switch (this) {
      case CardType.alex:
        return 1.0;
      case CardType.victoria:
        // Karty Victoria szersze np. o 50%
        return 1;
      case CardType.vanda:
        // Karty Victoria szersze np. o 50%
        return 1;
    }
  }

  /// Bazowa szerokość używana w obliczeniach liczby kolumn.
  /// Dla Victorii może być większa (np. +50%).
  double get baseWidth {
    switch (this) {
      case CardType.alex:
        return 500;
      case CardType.victoria:
        return 750; // 500 x 1.5
      case CardType.vanda:
        return 750; // 500 x 1.5
    }
  }

  double get basePadding {
    switch (this) {
      case CardType.alex:
        return 8;
      case CardType.victoria:
        return 25; 
      case CardType.vanda:
        return 10; 
    }
  }
    double get mapAspectRatio {
    switch (this) {
      case CardType.alex:
        return 16/9;
      case CardType.victoria:
        return 16/10; 
      case CardType.vanda:
        return 16/11; 
    }
  }
    double get gridRowCount {
    switch (this) {
      case CardType.alex:
        return 1;
      case CardType.victoria:
        return 2; 
      case CardType.vanda:
        return 2; 
    }
  }
}


final selectedCardProvider = StateProvider<CardType>((ref) {
  return CardType.vanda; // domyślnie Alex
});




class SelectedCardWidget extends ConsumerWidget {
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

  const SelectedCardWidget({
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
    final cardType = ref.watch(selectedCardProvider);

    switch (cardType) {
      case CardType.alex:
        return AlexCardWidget(
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
      case CardType.victoria:
        return VictoriaCardWidget(
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
      case CardType.vanda:
        return VictoriaNAlexCardWidget(
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
