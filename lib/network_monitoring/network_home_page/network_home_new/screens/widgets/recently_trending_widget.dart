import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/monitoring_home_pc.dart';
import 'package:hously_flutter/widgets/network_monitoring/component.dart';

class RecentlyTrendingWidget extends ConsumerWidget {
  final bool isMobile;

  const RecentlyTrendingWidget({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecentlyViewedSelected = ref.watch(monitoringSelectedTabProvider);

    return SizedBox(
      height: isMobile ? 340 : 466,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selectable Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              spacing: 12,
              children: [
                GestureDetector(
                  onTap: () => ref
                      .read(monitoringSelectedTabProvider.notifier)
                      .toggleTab(true),
                  child: Text(
                    'Recently Viewed',
                    style: TextStyle(
                      fontSize: isMobile ? 15 : 20,
                      fontWeight: FontWeight.w700,
                      color:
                          isRecentlyViewedSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => ref
                      .read(monitoringSelectedTabProvider.notifier)
                      .toggleTab(false),
                  child: Text(
                    'Trending Properties',
                    style: TextStyle(
                      fontSize: isMobile ? 15 : 20,
                      fontWeight: FontWeight.w700,
                      color: !isRecentlyViewedSelected
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white),

          // Display corresponding list
          SizedBox(
            height: isMobile ? 300 : 400,
            child: NMRecentlyViewedAds(),
          ),
        ],
      ),
    );
  }
}
