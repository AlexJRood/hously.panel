// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:latlong2/latlong.dart';

class MapAd extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Function()? onMapActivated; // Callback do aktywacji mapy

  const MapAd({
    super.key,
    required this.latitude,
    required this.longitude,
    this.onMapActivated, // Opcjonalny callback
  });

  @override
  MapAdState createState() => MapAdState();
}

class MapAdState extends State<MapAd> {
  bool _ignoreMapInteraction = true;

  void _toggleMapInteraction() {
    if (_ignoreMapInteraction && widget.onMapActivated != null) {
      widget.onMapActivated!(); // Wywołanie callbacka przed zmianą stanu
    }
    setState(() {
      _ignoreMapInteraction = !_ignoreMapInteraction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: IgnorePointer(
            ignoring:
                _ignoreMapInteraction, // Kontroluje, czy mapa ignoruje interakcje
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(widget.latitude, widget.longitude),
                  zoom: 13.0,
                  interactiveFlags: InteractiveFlag.all &
                      ~InteractiveFlag.rotate, // Wyłącza obracanie mapy
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
          onTap:
              _toggleMapInteraction, // Pozwala na włączenie interakcji z mapą tylko po kliknięciu na tekst
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _ignoreMapInteraction
                  ? "Kliknij tutaj, aby aktywować interakcje z mapą".tr
                  : "Interakcja z mapą jest aktywna".tr,
              style: AppTextStyles.interMedium,
            ),
          ),
        ),
      ],
    );
  }
}
