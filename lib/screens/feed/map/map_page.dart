import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/screens/feed/map/map_markers.dart';
import 'package:latlong2/latlong.dart';


final userLocationProvider = StateProvider<LatLng?>((ref) => null);

class MapPage extends ConsumerWidget {
  final Function(List<AdsListViewModel>) onFilteredAdsListViewsChanged;
  final MapController mapController = MapController();

  MapPage({super.key, required this.onFilteredAdsListViewsChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLocation = ref.watch(userLocationProvider);
    final addressFilter = ref.read(filterProvider.notifier).fullAddress;
    final adsListViewsAsyncValue = ref.watch(filterProvider);
    final hoveredProperty = ref.watch(hoveredPropertyProvider); // Use the global provider

    // Check the condition on startup or state changes.
    if (addressFilter.isNotEmpty) {
      _determinePosition(ref, address: addressFilter);
    } else if (userLocation == null) {
      _determinePosition(ref); // Fetch current position
    }


    return Scaffold(
      body: adsListViewsAsyncValue.when(
        data: (ads) {
          return FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: userLocation!,
              interactionOptions:InteractionOptions(
                flags:  InteractiveFlag.pinchZoom | InteractiveFlag.drag
              ),
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  var bounds = mapController.camera.visibleBounds;
                  var filtered = ads.where((ads) {
                    var latLng = LatLng(ads.latitude, ads.longitude);
                    return bounds.contains(latLng);
                  }).toList();
                  onFilteredAdsListViewsChanged(filtered);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                tileProvider: CancellableNetworkTileProvider(),
              ),
              MarkerLayer(
                markers: makeMarkersFromAdsListViews(ads, context, ref, hoveredProperty)
                    .map((marker) {
                  return Marker(
                    point: marker.point,
                    width: 120.0,
                    height: 60.0,
                    child: marker.child,
                  );
                }).toList(),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Wystąpił błąd: $error'.tr)),
      ),
    );  }

  Future<void> _determinePosition(WidgetRef ref, {String? address}) async {
    LatLng? coordinates;

    if (address != null && address.isNotEmpty) {
      coordinates = await getCoordinatesFromAddress(address, ref);
      if (coordinates != null) {
        ref.read(userLocationProvider.notifier).state = coordinates;
        return;
      }
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setDefaultLocation(ref);
      return Future.error('Usługi lokalizacyjne są wyłączone. Ustawiono domyślną lokalizację na Warszawę.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _setDefaultLocation(ref);
        return Future.error('Odmowa uprawnień do lokalizacji. Ustawiono domyślną lokalizację na Warszawę.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _setDefaultLocation(ref);
      return Future.error('Uprawnienia do lokalizacji są permanentnie odmówione. Ustawiono domyślną lokalizację na Warszawę.');
    }

    Position position = await Geolocator.getCurrentPosition();
    ref.read(userLocationProvider.notifier).state = LatLng(position.latitude, position.longitude);
  }

  void _setDefaultLocation(WidgetRef ref) {
    ref.read(userLocationProvider.notifier).state = const LatLng(52.229676, 21.012229);
  }
}

Future<LatLng?> getCoordinatesFromAddress(String address, dynamic ref) async {
  final encodedAddress = Uri.encodeComponent(address);

  try {
    final response = await ApiServices.get(
      ref: ref,
      URLs.nominatimMap(encodedAddress),
      hasToken: true,
      headers: {'User-Agent': 'Hously1.0'},
    );

    if (response != null && response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.data);
      if (data.isNotEmpty) {
        final Map<String, dynamic> firstResult = data.first;
        final double lat = double.parse(firstResult['lat']);
        final double lon = double.parse(firstResult['lon']);
        return LatLng(lat, lon);
      }
    }
  } catch (e) {}

  return null;
}

