import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:latlong2/latlong.dart';

class MapAd extends ConsumerStatefulWidget {
  final double latitude;
  final double longitude;
  final Function()? onMapActivated;

  const MapAd({
    super.key,
    required this.latitude,
    required this.longitude,
    this.onMapActivated,
  });

  @override
  ConsumerState<MapAd> createState() => _MapAdState();
}

class _MapAdState extends ConsumerState<MapAd> {
  bool _ignoreMapInteraction = true;

  void _toggleMapInteraction() {
    if (_ignoreMapInteraction && widget.onMapActivated != null) {
      widget.onMapActivated!();
    }
    setState(() {
      _ignoreMapInteraction = !_ignoreMapInteraction;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    return Column(
      children: [
        Expanded(
          child: IgnorePointer(
            ignoring: _ignoreMapInteraction,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(widget.latitude, widget.longitude),
                  initialZoom: 13.0,
                  interactionOptions:InteractionOptions(
                      flags:  InteractiveFlag.pinchZoom | InteractiveFlag.drag
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(widget.latitude, widget.longitude),
                        child: const Icon(
                          Icons.location_city,
                          color: AppColors.buttonGradient2,
                          size: 35.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _toggleMapInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _ignoreMapInteraction
                  ? "Kliknij tutaj, aby aktywować interakcje z mapą".tr
                  : "Interakcja z mapą jest aktywna".tr,
              style: AppTextStyles.interMedium
                  .copyWith(color: theme.popUpIconColor),
            ),
          ),
        ),
      ],
    );
  }
}
