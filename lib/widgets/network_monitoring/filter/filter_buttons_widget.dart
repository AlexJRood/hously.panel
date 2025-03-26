import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/search_page/filters_provider.dart';
import 'package:hously_flutter/widgets/network_monitoring/filter/fileds.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';

class FilterButtonsWidget extends ConsumerWidget {
  final dynamic navigationHistoryProvider;

  const FilterButtonsWidget({
    super.key,
    required this.navigationHistoryProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       
                        Expanded(
                          flex:1,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                ref.read(networkMonitoringFilterCacheProvider.notifier)
                                    .clearFiltersNM();
                                ref.read(
                                        networkMonitoringFilterButtonProvider.notifier)
                                    .clearUiFiltersNM();
                                ref.read(networkMonitoringFilterProvider.notifier)
                                    .applyFiltersFromCacheNM(
                                        ref.read(networkMonitoringFilterCacheProvider
                                            .notifier),
                                        ref);
                              },
                              child: Material(
                                child: Container(
                                  height: 30,
                                   decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                    color: const Color.fromRGBO(255, 255, 255, 1),)),
                                
                                  child: Center(
                                    child: Text('Wyczyść'.tr,
                                      style: const TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                         Expanded(
                          flex: 2,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                ref.read(networkMonitoringFilterProvider.notifier)
                                    .applyFiltersFromCacheNM(
                                        ref.read(networkMonitoringFilterCacheProvider
                                            .notifier),
                                        ref);
                              },
                              child: Material(
                                child: Container(
                                  height: 30,
                                   decoration: BoxDecoration(
                                          color: const Color.fromRGBO(200, 200, 200, 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Zastosuj filtry'.tr,
                                        style: AppTextStyles.interRegular14
                                            .copyWith(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
               
            ],
          ),
        ),
      ),
    );
  }
}
