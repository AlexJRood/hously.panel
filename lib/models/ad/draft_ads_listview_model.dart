import 'dart:convert';

import 'package:hously_flutter/const/url.dart';

class DraftAdsListViewModel {
  final int id;
  final String address;
  final String title;
  final double price;
  final String currency;
  final String description;
  final List<String> images;
  final int? floor;
  final int? totalFloors;
  final String street;
  final String city;
  final String state;
  final String zipcode;
  final int? rooms;
  final int? bathrooms;
  final double squareFootage;
  final double? lotSize;
  final String propertyForm;
  final String marketType;
  final String offerType;
  final String country;
  final String? phoneNumber;
  final double latitude;
  final double longitude;

  final String? heatingType;
  final String? buildingMaterial;
  final int? buildYear;
  final bool? balcony;
  final bool? terrace;
  final bool? sauna;
  final bool? jacuzzi;
  final bool? basement;
  final bool? elevator;
  final bool? garden;
  final bool? airConditioning;
  final bool? garage;
  final bool? parkingSpace;

  const DraftAdsListViewModel({
    required this.address,
    required this.id,
    required this.title,
    required this.price,
    required this.currency,
    required this.description,
    required this.images,
    required this.floor,
    required this.totalFloors,
    required this.street,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.rooms,
    required this.bathrooms,
    required this.squareFootage,
    required this.lotSize,
    required this.propertyForm,
    required this.marketType,
    required this.offerType,
    required this.country,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    this.heatingType,
    this.buildingMaterial,
    this.buildYear,
    this.balcony,
    this.terrace,
    this.sauna,
    this.jacuzzi,
    this.basement,
    this.elevator,
    this.garden,
    this.airConditioning,
    this.garage,
    this.parkingSpace,
  });

  factory DraftAdsListViewModel.fromJson(Map<String, dynamic> json) {
    List<String> imagesList = [];
    if (json['images'] != null && json['images'].isNotEmpty) {
      imagesList = List<String>.from(
          jsonDecode(json['images']).map((image) => URLs.baseUrl + image));
    }
    return DraftAdsListViewModel(
      id: json['id'],
      address: json['adrress'] ?? '',
      title: json['title'] ?? '',
      price: double.parse(json['price'].toString()),
      currency: json['currency'] ?? 'PLN',
      description: json['description'],
      images: imagesList,
      floor: json['floor'],
      totalFloors: json['total_floors'],
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipcode: json['zipcode'] ?? '',
      rooms: json['rooms'],
      bathrooms: json['bathrooms'],
      squareFootage: double.parse(json['square_footage'] ?? '0'),
      lotSize: json['lot_size'] != null
          ? double.parse(json['lot_size'].toString())
          : null,
      propertyForm: json['property_form'] ?? '',
      marketType: json['market_type'] ?? '',
      offerType: json['offer_type'] ?? '',
      country: json['country'] ?? '',
      phoneNumber: json['phone_number']?.toString(),
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString()) ?? 0.0
          : 0.0,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString()) ?? 0.0
          : 0.0,
      heatingType: json['heating_type'],
      buildingMaterial: json['building_material'],
      buildYear: json['build_year'],
      balcony: json['balcony'],
      terrace: json['terrace'],
      sauna: json['sauna'],
      jacuzzi: json['jacuzzi'],
      basement: json['basement'],
      elevator: json['elevator'],
      garden: json['garden'],
      airConditioning: json['air_conditioning'],
      garage: json['garage'],
      parkingSpace: json['parking_space'],
    );
  }
}
