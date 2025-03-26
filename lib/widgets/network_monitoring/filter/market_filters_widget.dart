import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/network_monitoring/filter/fileds.dart';

class MarketFiltersWidget extends StatelessWidget {
  final String? currentCountry;
  final double dynamicBoxHeightGroup;
  final double dynamicBoxHeightGroupSmall;
  final dynamic ref;

  const MarketFiltersWidget({
    super.key,
    required this.currentCountry,
    required this.dynamicBoxHeightGroup,
    required this.dynamicBoxHeightGroupSmall,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Dodatkowe filtry'.tr,
                style: AppTextStyles.interSemiBold.copyWith(fontSize: 18,color:  Colors.white)),
          ],
        ),
        SizedBox(height: dynamicBoxHeightGroupSmall),
        Row(
          children: [
             Expanded(
              child: NetworkMonitoringFilterButton(
                text: 'Rynek pierwotny'.tr,
                filterValue: 'new',
                filterKey: 'market_type',
              ),
            ),
            SizedBox(width: dynamicBoxHeightGroup),
             Expanded(
              child: NetworkMonitoringFilterButton(
                text: 'Rynek wtórny'.tr,
                filterValue: 'use',
                filterKey: 'market_type',
              ),
            ),
          ],
        ),
        // SizedBox(height: dynamicBoxHeightGroup),
        // SizedBox(
        //   child: BuildDropdownButtonFormField(
        //     currentValue: currentCountry,
        //     items:  [
        //       'Blok'.tr,
        //       'Apartamentowiec'.tr,
        //       'Kamienica'.tr,
        //       'Wieżowiec'.tr,
        //       'Loft',
        //       'Szeregowiec'.tr,
        //       'Plomba'.tr
        //     ],
        //     labelText: 'Rodzaj zabudowy'.tr,
        //     filterKey: 'building_type',
        //   ),
        // ),
        // SizedBox(height: dynamicBoxHeightGroup),
        // SizedBox(
        //   child: BuildDropdownButtonFormField(
        //     currentValue: currentCountry,
        //     items:  [
        //       'Gazowe'.tr,
        //       'Elektryczne'.tr,
        //       'Miejskie'.tr,
        //       'Pompa ciepła'.tr,
        //       'Olejowe'.tr,
        //       'Nie podono informacji'.tr,
        //       'Wszystkie'.tr
        //     ],
        //     labelText: 'Rodzaj ogrzewania'.tr,
        //     filterKey: 'heater_type',
        //   ),
        // ),
        // SizedBox(height: dynamicBoxHeightGroup),
        // SizedBox(
        //   child: BuildDropdownButtonFormField(
        //     currentValue: currentCountry,
        //     items:  [
        //       'Dowolna'.tr,
        //       'Z ostatnich 24h'.tr,
        //       'Z ostatnich 3 dni'.tr,
        //       'Z ostatnich 7 dni'.tr,
        //       'Z ostatnich 14 dni'.tr,
        //       'Z ostatnich 30 dni'.tr
        //     ],
        //     labelText: 'Aktualność oferty'.tr,
        //     filterKey: 'aktualnosc_oferty',
        //   ),
        // ),
        // SizedBox(height: dynamicBoxHeightGroup),
        // SizedBox(
        //   child: BuildDropdownButtonFormField(
        //     currentValue: currentCountry,
        //     items:  [
        //       'Dowolna'.tr,
        //       'Cegła'.tr,
        //       'Wielka płyta'.tr,
        //       'Drewno'.tr,
        //       'Pustak'.tr,
        //       'Keramzyt'.tr,
        //       'Beton'.tr,
        //       'Silikat'.tr,
        //       'Beton komórkowy'.tr,
        //       'Żelbet'.tr
        //     ],
        //     labelText: 'Materiał budynku'.tr,
        //     filterKey: 'building_material',
        //   ),
        // ),
        // SizedBox(height: dynamicBoxHeightGroup),
        // SizedBox(
        //   child: BuildDropdownButtonFormField(
        //     currentValue: currentCountry,
        //     items:  [
        //       'Agent nieruchomości'.tr,
        //       'Deweloper'.tr,
        //       'Osoba prywatna'.tr,
        //       'Dowolna'.tr
        //     ],
        //     labelText: 'Ogłoszeniodawca'.tr,
        //     filterKey: 'advertiser',
        //   ),
        // ),
      ],
    );
  }

  // Pamiętaj, aby zdefiniować metody `buildDropdownButtonFormField` i `NetworkMonitoringFilterButton` lub zaimportować je, jeśli są w oddzielnym pliku.
}
