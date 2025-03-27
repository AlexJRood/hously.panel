import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/ads_managment/models/ad_list_view_model.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:latlong2/latlong.dart';

class CustomMarkerWidget extends StatelessWidget {
  final String value;
  final bool isHovered;

  const CustomMarkerWidget({
    super.key,
    required this.value,
    this.isHovered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isHovered ? AppColors.buttonGradient2: AppColors.buttonGradient1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 0,
          height: 0,
          decoration: BoxDecoration(
            border: Border(
              left: const BorderSide(width: 6, color: Colors.transparent),
              right: const BorderSide(width: 6, color: Colors.transparent),
              bottom: BorderSide(
                width: 12,
                color: isHovered ? AppColors.buttonGradient2 : AppColors.buttonGradient1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List<Marker> makeMarkersFromAdsListViews(
    List<AdsListViewModel> adsListViews,
    BuildContext context,
    WidgetRef ref,
    AdsListViewModel? hoveredProperty, // Pass the hovered property
    ) {
  return adsListViews.map((ad) {
    final tag = 'mapMarker${ad.id}';
    final isHovered = hoveredProperty != null && hoveredProperty.id == ad.id;

    return Marker(
      width: 120.0,
      height: 60.0,
      point: LatLng(ad.latitude, ad.longitude),
      child: GestureDetector(
        onTap: () {
          ref.read(navigationService).pushNamedScreen(
            '/${Routes.feedPop}',
            data: {'tag': tag, 'ad': ad},
          );
        },
        child: CustomMarkerWidget(
          value: '${ad.price} ${ad.currency}',
          isHovered: isHovered,
        ),
      ),
    );
  }).toList();
}