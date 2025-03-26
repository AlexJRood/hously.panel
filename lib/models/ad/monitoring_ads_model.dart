import 'dart:convert';

double cleanPrice(dynamic value) {
    if (value == null) return 0.0;
    String priceStr = value.toString()
        .replaceAll(RegExp(r'[^0-9,\.]'), '')  // Usuwa wszystko oprócz cyfr, przecinka i kropki
        .replaceAll(',', '.');  // Zamienia przecinek na kropkę dla konwersji

    return double.tryParse(priceStr) ?? 0.0;  // Próbuje przekonwertować na double
  }

class MonitoringAdsModel {
  final int id;
  final String? url;
  final String? estateType;
  final String? offerType;
  final String title;
  final String? description;
  final String currency;

  final double? price;
  final double? pricePerM2;
  final double? rent;

  final String? marketType;
  final String? buildYear;
  final String? estateCondition;
  final String? heatingType;
  final String? buildingType;
  final String? floor;
  final String? totalFloors;
  final String? rooms;
  final String? bathrooms;

  final double? squareFootage;

  // Obiekty relacyjne
  final List<String> images;
  final OfferData? offerData;
  final AdditionalInfo? additionalInfo;
  final BoolLeanFields? boolLeanFields;
  final AddressData? address;
  final Offerer? offerer;
  final OffererPhone? offererPhone;
  final ListingCounter? listingCounter;
  final bool isPro;

  MonitoringAdsModel({
    required this.id,
    required this.title,
    required this.currency,
    this.url,
    this.estateType,
    this.offerType,
    this.description,
    this.price,
    this.pricePerM2,
    this.rent,
    this.marketType,
    this.buildYear,
    this.estateCondition,
    this.heatingType,
    this.buildingType,
    this.address,
    this.floor,
    this.totalFloors,
    this.rooms,
    this.bathrooms,
    this.squareFootage,
    required this.images,
    required this.isPro,
    this.boolLeanFields,
    this.offerData,
    this.additionalInfo,
    this.offerer,
    this.offererPhone,
    this.listingCounter,
  });

  /// 🔥 **Metoda czyszcząca cenę** (usuwa " zł" i inne znaki, konwertuje na double)


  factory MonitoringAdsModel.fromJson(Map<String, dynamic> json) {
    List<String> imagesList = [];

  if (json['images'] != null && json['images']['images'] != null) {
    if (json['images']['images'] is List) {
      imagesList = (json['images']['images'] as List)
          .map((image) => image.toString())
          .toList();
    } else if (json['images']['images'] is String) {
      try {
        imagesList = List<String>.from(
          jsonDecode(json['images']['images']).map((image) => image.toString()),
        );
      } catch (e) {
        print("Błąd dekodowania images: $e");
      }
    }

    // Naprawa niepoprawnych URL-i
    imagesList = imagesList.map((url) {
      if (url.startsWith("https:/") && !url.startsWith("https://")) {
        return url.replaceFirst("https:/", "https://");
      }
      return url;
    }).toList();
  }


    return MonitoringAdsModel(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      estateType: json['estate_type'] ?? '',
      offerType: json['offer_type'] ?? '',
      title: json['title'] ?? 'Brak tytułu',
      description: json['description'] ?? '',

      currency: json['currency'] ?? 'PLN',
      price: cleanPrice(json['price']),
      pricePerM2: cleanPrice(json['price_per_m2']),
      rent: cleanPrice(json['rent']),

      marketType: json['market_type'] ?? '',
      buildYear: json['build_year'] ?? '',
      estateCondition: json['estate_condition'] ?? '',
      heatingType: json['heating_type'] ?? '',
      buildingType: json['building_type'] ?? '',
      isPro: json['isPro'] ?? false,

      floor: json['floor'] ?? '',
      totalFloors: json['floors_num'] ?? '',
      rooms: json['rooms'] ?? '',
      bathrooms: json['bathroom_number'] ?? '',
      squareFootage: cleanPrice(json['square_footage']),
      images: imagesList,
      address: json['address'] != null 
        ? AddressData.fromJson(json['address']) 
        : AddressData(street: 'ulica', city: 'miasto', country: 'kraj', state: 'województwo', province: 'powiat', district: 'dzielnica', lat: 0.0, lon:0.0),  // Domyślny pusty obiekt

      boolLeanFields: json['bool_fields'] != null ? BoolLeanFields.fromJson(json['bool_fields']) : null,
      offerData: json['offer_data'] != null ? OfferData.fromJson(json['offer_data']) : null,
      additionalInfo: json['additional_info'] != null ? AdditionalInfo.fromJson(json['additional_info']) : null,
      offerer: json['offerer'] != null ? Offerer.fromJson(json['offerer']) : null,
      offererPhone: json['offerer_phone'] != null ? OffererPhone.fromJson(json['offerer_phone']) : null,
      listingCounter: json['listing_counter'] != null ? ListingCounter.fromJson(json['listing_counter']) : null,
    );
  }
}


class BoolLeanFields {
  final bool elevator;
  final String media;
  final bool electricity;
  final bool water;
  final bool gas;
  final bool phone;
  final bool internet;
  final bool sewerage;
  final bool equipment;
  final bool garden;
  final bool garage;
  final bool basement;
  final bool attic;
  final bool terraces;
  final bool separateKitchen;
  final String balcony;
  final String parkingSpace;

  BoolLeanFields({
    required this.elevator,
    required this.media,
    required this.electricity,
    required this.water,
    required this.gas,
    required this.phone,
    required this.internet,
    required this.sewerage,
    required this.equipment,
    required this.garden,
    required this.garage,
    required this.basement,
    required this.attic,
    required this.terraces,
    required this.separateKitchen,
    required this.balcony,
    required this.parkingSpace,
  });

  factory BoolLeanFields.fromJson(Map<String, dynamic> json) {
    return BoolLeanFields(
      elevator: json['elevator'] ?? false,
      media: json['media'] ?? '',
      electricity: json['electricity'] ?? false,
      water: json['water'] ?? false,
      gas: json['gas'] ?? false,
      phone: json['phone'] ?? false,
      internet: json['internet'] ?? false,
      sewerage: json['sewerage'] ?? false,
      equipment: json['equipment'] ?? false,
      garden: json['garden'] ?? false,
      garage: json['garage'] ?? false,
      basement: json['basement'] ?? false,
      attic: json['attic'] ?? false,
      terraces: json['terraces'] ?? false,
      separateKitchen: json['seprete_kitchen'] ?? false,
      balcony: json['balcony'] ?? 'false',
      parkingSpace: json['parking_space'] ?? 'false',
    );
  }
}

class AddressData {
  final String street;
  final String city;
  final String country;
  final String state;
  final String district;
  final String? province;
  final String? commune;
  final String? housingEstate;
  final String? zipcode;
  final String? neighborhood;
  final double? lon;
  final double? lat;

  AddressData({
    required this.street,
    required this.city,
    required this.country,
    required this.state,
    required this.district,
    this.province,
    this.commune,
    this.housingEstate,
    this.zipcode,
    this.neighborhood,
    this.lon,
    this.lat,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      street: json['street'] ?? 'ulica',
      city: json['city'] ?? 'miasto',
      country: json['country'] ?? 'kraj',
      state: json['state'] ?? '',
      province: json['province'] ?? '',
      commune: json['commune'] ?? '',
      district: json['district'] ?? '',
      housingEstate: json['housing_estate'] ?? '',
      zipcode: json['zipcode'] ?? '',
      neighborhood: json['neighborhood'] ?? '',
      lon: cleanPrice(json['lon']),
      lat: cleanPrice(json['lat']),
    );
  }
}


class OfferData {
  final String siteId;
  final String ownershipForm;
  final String availableFrom;
  final String landAndMortgageRegister;
  final String createdAt;

  OfferData({
    required this.siteId,
    required this.ownershipForm,
    required this.availableFrom,
    required this.landAndMortgageRegister,
    required this.createdAt,
  });

  factory OfferData.fromJson(Map<String, dynamic> json) {
    return OfferData(
      siteId: json['site_id'] ?? '',
      ownershipForm: json['ownership_form'] ?? '',
      availableFrom: json['available_from'] ?? '',
      landAndMortgageRegister: json['land_and_mortgage_register'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class AdditionalInfo {
  final String windows;
  final String atticType;
  final String buildingMaterial;
  final String security;

  // Dla działek
  final String fencing;
  final String accessRoad;
  final String location;
  final String plotType;
  final String dimensions;

  // Dla lokali użytkowych
  final String premisesLocation;
  final String purpose;

  // Dla domów
  final String locationInfo;
  final String roof;
  final String recreationalHouse;
  final String roofCovering;

  // Dla hal i magazynów
  final String construction;
  final String height;
  final String officeRooms;
  final String socialFacilities;
  final String parking;
  final String ramp;
  final String floorMaterial;

  // Dla garaży
  final String lighting;

  AdditionalInfo({
    required this.windows,
    required this.atticType,
    required this.buildingMaterial,
    required this.security,
    required this.fencing,
    required this.accessRoad,
    required this.location,
    required this.plotType,
    required this.dimensions,
    required this.premisesLocation,
    required this.purpose,
    required this.locationInfo,
    required this.roof,
    required this.recreationalHouse,
    required this.roofCovering,
    required this.construction,
    required this.height,
    required this.officeRooms,
    required this.socialFacilities,
    required this.parking,
    required this.ramp,
    required this.floorMaterial,
    required this.lighting,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      windows: json['windows'] ?? '',
      atticType: json['attic_type'] ?? '',
      buildingMaterial: json['building_material'] ?? '',
      security: json['security'] ?? '',
      fencing: json['fencing'] ?? '',
      accessRoad: json['access_road'] ?? '',
      location: json['location'] ?? '',
      plotType: json['plot_type'] ?? '',
      dimensions: json['dimensions'] ?? '',
      premisesLocation: json['premises_location'] ?? '',
      purpose: json['purpose'] ?? '',
      locationInfo: json['location_info'] ?? '',
      roof: json['roof'] ?? '',
      recreationalHouse: json['recreational_house'] ?? '',
      roofCovering: json['roof_covering'] ?? '',
      construction: json['construction'] ?? '',
      height: json['height'] ?? '',
      officeRooms: json['office_rooms'] ?? '',
      socialFacilities: json['social_facilities'] ?? '',
      parking: json['parking'] ?? '',
      ramp: json['ramp'] ?? '',
      floorMaterial: json['floor_material'] ?? '',
      lighting: json['lighting'] ?? '',
    );
  }
}

class Offerer {
  final String advertiserName;
  final String advertiserType;
  final String remoteService;

  Offerer({
    required this.advertiserName,
    required this.advertiserType,
    required this.remoteService,
  });

  factory Offerer.fromJson(Map<String, dynamic> json) {
    return Offerer(
      advertiserName: json['advertiser_name'] ?? '',
      advertiserType: json['advertiser_type'] ?? '',
      remoteService: json['remote_service'] ?? '',
    );
  }
}

class OffererPhone {
  final String advertiserPhone;

  OffererPhone({required this.advertiserPhone});

  factory OffererPhone.fromJson(Map<String, dynamic> json) {
    return OffererPhone(
      advertiserPhone: json['advertiser_phone'] ?? '',
    );
  }
}

class ListingCounter {
  final String viewCount;

  ListingCounter({required this.viewCount});

  factory ListingCounter.fromJson(Map<String, dynamic> json) {
    return ListingCounter(
      viewCount: json['view_count'] ?? '',
    );
  }
}
