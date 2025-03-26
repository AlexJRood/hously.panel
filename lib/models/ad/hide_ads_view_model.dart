import 'dart:convert';

import 'package:hously_flutter/const/url.dart';

class HideAdsViewModel {
  final int id;
  final int sellerId;
  final String title;
  final double price;
  final String currency;
  final String description;
  final List<String> images;
  final int floor;
  final int totalFloors;
  final String street;
  final String city;
  final String state;
  final String zipcode;
  final int rooms;
  final int bathrooms;
  final double squareFootage;
  final double lotSize;
  final String propertyForm;
  final String marketType;
  final String offerType;
  final String country;
  final int phoneNumber;
  final double latitude;
  final double longitude;

  final String? heatingType;
  final String? buildingMaterial;
  final int? buildYear;
  final bool balcony;
  final bool terrace;
  final bool sauna;
  final bool jacuzzi;
  final bool basement;
  final bool elevator;
  final bool garden;
  final bool airConditioning;
  final bool garage;
  final bool parkingSpace;

  const HideAdsViewModel({
    this.id = 0,
    this.sellerId = 0,
    this.title = '',
    this.price = 0.0,
    this.currency = '',
    this.description = '',
    this.images = const [],
    this.floor = 0,
    this.totalFloors = 0,
    this.street = '',
    this.city = '',
    this.state = '',
    this.zipcode = '',
    this.rooms = 0,
    this.bathrooms = 0,
    this.squareFootage = 0.0,
    this.lotSize = 0.0,
    this.propertyForm = '',
    this.marketType = '',
    this.offerType = '',
    this.country = '',
    this.phoneNumber = 0,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.heatingType,
    this.buildingMaterial,
    this.buildYear,
    this.balcony = false,
    this.terrace = false,
    this.sauna = false,
    this.jacuzzi = false,
    this.basement = false,
    this.elevator = false,
    this.garden = false,
    this.airConditioning = false,
    this.garage = false,
    this.parkingSpace = false,
  });
  HideAdsViewModel copyWith({
    int? id,
    int? sellerId,
    String? title,
    double? price,
    String? currency,
    String? description,
    List<String>? images,
    int? floor,
    int? totalFloors,
    String? street,
    String? city,
    String? state,
    String? zipcode,
    int? rooms,
    int? bathrooms,
    double? squareFootage,
    double? lotSize,
    String? propertyForm,
    String? marketType,
    String? offerType,
    String? country,
    int? phoneNumber,
    double? latitude,
    double? longitude,
    String? heatingType,
    String? buildingMaterial,
    int? buildYear,
    bool? balcony,
    bool? terrace,
    bool? sauna,
    bool? jacuzzi,
    bool? basement,
    bool? elevator,
    bool? garden,
    bool? airConditioning,
    bool? garage,
    bool? parkingSpace,
  }) {
    return HideAdsViewModel(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      title: title ?? this.title,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      images: images ?? this.images,
      floor: floor ?? this.floor,
      totalFloors: totalFloors ?? this.totalFloors,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipcode: zipcode ?? this.zipcode,
      rooms: rooms ?? this.rooms,
      bathrooms: bathrooms ?? this.bathrooms,
      squareFootage: squareFootage ?? this.squareFootage,
      lotSize: lotSize ?? this.lotSize,
      propertyForm: propertyForm ?? this.propertyForm,
      marketType: marketType ?? this.marketType,
      offerType: offerType ?? this.offerType,
      country: country ?? this.country,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      heatingType: heatingType ?? this.heatingType,
      buildingMaterial: buildingMaterial ?? this.buildingMaterial,
      buildYear: buildYear ?? this.buildYear,
      balcony: balcony ?? this.balcony,
      terrace: terrace ?? this.terrace,
      sauna: sauna ?? this.sauna,
      jacuzzi: jacuzzi ?? this.jacuzzi,
      basement: basement ?? this.basement,
      elevator: elevator ?? this.elevator,
      garden: garden ?? this.garden,
      airConditioning: airConditioning ?? this.airConditioning,
      garage: garage ?? this.garage,
      parkingSpace: parkingSpace ?? this.parkingSpace,
    );
  }
  factory HideAdsViewModel.fromJson(Map<String, dynamic> json) {
    List<String> imagesList = [];
    if (json['images'] != null && json['images'].isNotEmpty) {
      imagesList = List<String>.from(
          jsonDecode(json['images']).map((image) => URLs.baseUrl + image));
    }
    return HideAdsViewModel(
      sellerId: json['user'] ?? 0,
      id: json['id'],
      title: json['title'],
      price: double.parse(json['price'].toString()),
      currency: json['currency'],
      description: json['description'],
      images: imagesList,
      floor: json['floor'] ?? 0,
      totalFloors: json['total_floors'] ?? 0,
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipcode: json['zipcode'] ?? '',
      rooms: json['rooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      squareFootage: double.parse(json['square_footage'] ?? '0'),
      lotSize: double.parse(json['lot_size'] ?? '0'),
      propertyForm: json['property_form'] ?? '',
      marketType: json['market_type'] ?? '',
      offerType: json['offer_type'] ?? '',
      country: json['country'] ?? '',
      phoneNumber: json['phone_number'] ?? 0,
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString()) ?? 0.0
          : 0.0,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString()) ?? 0.0
          : 0.0,
      heatingType: json['heating_type'],
      buildingMaterial: json['building_material'],
      buildYear: json['build_year'],
      balcony: json['balcony'] ?? false,
      terrace: json['terrace'] ?? false,
      sauna: json['sauna'] ?? false,
      jacuzzi: json['jacuzzi'] ?? false,
      basement: json['basement'] ?? false,
      elevator: json['elevator'] ?? false,
      garden: json['garden'] ?? false,
      airConditioning: json['air_conditioning'] ?? false,
      garage: json['garage'] ?? false,
      parkingSpace: json['parking_space'] ?? false,
    );
  }
}
