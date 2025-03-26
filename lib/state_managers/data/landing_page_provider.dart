import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedLocationProvider = StateProvider<String>((ref) => '');
final isLocationVisibleProvider = StateProvider<bool>((ref) => false);
final isPropertyVisibleProvider = StateProvider<bool>((ref) => false);
final selectedPropertyProvider = StateProvider<String>((ref) => '');
final selectedPriceRangeProvider = StateProvider<String>((ref) => '');
final isPriceSelectedProvider = StateProvider<bool>((ref) => false);
final selectedMeterRangeProvider = StateProvider<String>((ref) => '');
final isSelectedMeterRangeProvider = StateProvider<bool>((ref) => false);
