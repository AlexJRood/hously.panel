import 'dart:convert';
import 'package:hously_flutter/api_services/url.dart';

class AdsListViewModel {
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
  final bool isPro;

  /// **✅ Default Constructor with Default Values**
  const AdsListViewModel({
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
    this.isPro = false,
  });

  /// **✅ `copyWith` Method for Partial Updates**
  AdsListViewModel copyWith({
    int? id,
  }) {
    return AdsListViewModel(
      id: id ?? this.id, // ✅ Only updates `id`
      sellerId: sellerId,
      title: title,
      price: price,
      currency: currency,
      description: description,
      images: images,
      floor: floor,
      totalFloors: totalFloors,
      street: street,
      city: city,
      state: state,
      zipcode: zipcode,
      rooms: rooms,
      bathrooms: bathrooms,
      squareFootage: squareFootage,
      lotSize: lotSize,
      propertyForm: propertyForm,
      marketType: marketType,
      offerType: offerType,
      country: country,
      phoneNumber: phoneNumber,
      latitude: latitude,
      longitude: longitude,
      heatingType: heatingType,
      buildingMaterial: buildingMaterial,
      buildYear: buildYear,
      balcony: balcony,
      terrace: terrace,
      sauna: sauna,
      jacuzzi: jacuzzi,
      basement: basement,
      elevator: elevator,
      garden: garden,
      airConditioning: airConditioning,
      garage: garage,
      parkingSpace: parkingSpace,
      isPro: isPro,
    );
  }

  /// **✅ Factory Method to Convert JSON to Object**
  factory AdsListViewModel.fromJson(Map<String, dynamic> json) {
    List<String> imagesList = [];
    if (json['advertisement_images'] != null) {
      if (json['advertisement_images'] is List) {
        imagesList = (json['advertisement_images'] as List).map((image) {
          return URLs.baseUrl + image.toString();
        }).toList();
      } else if (json['advertisement_images'] is String) {
        imagesList = List<String>.from(
          jsonDecode(json['advertisement_images']).map((image) => URLs.baseUrl + image),
        );
      }
    }

    return AdsListViewModel(
      id: json['id'] ?? 0,
      sellerId: json['user'] ?? 0,
      title: json['title'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      currency: json['currency'] ?? '',
      description: json['description'] ?? '',
      images: imagesList,
      floor: json['floor'] ?? 0,
      totalFloors: json['total_floors'] ?? 0,
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipcode: json['zipcode'] ?? '',
      rooms: json['rooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      squareFootage: double.tryParse(json['square_footage']?.toString() ?? '0') ?? 0.0,
      lotSize: double.tryParse(json['lot_size']?.toString() ?? '0') ?? 0.0,
      propertyForm: json['property_form'] ?? '',
      marketType: json['market_type'] ?? '',
      offerType: json['offer_type'] ?? '',
      country: json['country'] ?? '',
      phoneNumber: json['phone_number'] ?? 0,
      latitude: double.tryParse(json['latitude']?.toString() ?? '0') ?? 0.0,
      longitude: double.tryParse(json['longitude']?.toString() ?? '0') ?? 0.0,
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
      isPro: json['is_premium'] ?? false,
    );
  }
}
