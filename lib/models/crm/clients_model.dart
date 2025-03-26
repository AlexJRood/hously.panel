import 'package:hously_flutter/const/url.dart';

const configUrl = URLs.baseUrl;

const defaultAvatarUrl = '$configUrl/media/avatars/avatar.jpg';

class UserContactModel {
  final int id;
  final String? contactStatus; 
  final String? responsiblePerson;
  final bool? isStar; 
  final String? avatar; 
  final String name; 
  final String? lastName; 
  final String? email; 
  final String? phoneNumber; 
  final String? description; 
  final String? note; 
  final String? contactType; 
  final DateTime? dateCreated; 
  final DateTime? lastUpdated; 
  final String? serviceType; 

  const UserContactModel({
    required this.id,
    this.contactStatus,
    this.responsiblePerson,
    this.isStar,
    this.avatar,
    required this.name,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.description,
    this.note,
    this.contactType,
    this.dateCreated,
    this.lastUpdated,
    this.serviceType,
  });

  factory UserContactModel.fromJson(Map<String, dynamic> json) {
    return UserContactModel(
      id: json['id'] ?? 0, // Wymagane pole, domyślnie 0
      contactStatus: json['contact_status']?.toString(), // Obsługuje null
      responsiblePerson: json['responsible_person']?.toString(), // Obsługuje null
      isStar: json['star'] ?? false, // Domyślnie false
      avatar: json['avatar'] ?? defaultAvatarUrl, // Ustawienie domyślnego avatara
      name: json['name'] ?? 'Unknown', // Wymagane pole, domyślnie "Unknown"
      lastName: json['last_name'], // Obsługuje null
      email: json['email'], // Obsługuje null
      phoneNumber: json['phone_number'], // Obsługuje null
      description: json['description'], // Obsługuje null
      note: json['note'], // Obsługuje null
      contactType: json['contact_type'], // Obsługuje null
      dateCreated: json['date_created'] != null
          ? DateTime.tryParse(json['date_created']) // Bezpieczne parsowanie daty
          : null,
      lastUpdated: json['last_updated'] != null
          ? DateTime.tryParse(json['last_updated']) // Bezpieczne parsowanie daty
          : null,
      serviceType: json['service_type'], // Obsługuje null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contact_status': contactStatus, // Eksport identyfikatora
      'responsible_person': responsiblePerson, // Eksport identyfikatora
      'star': isStar,
      'avatar': avatar,
      'name': name,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'description': description,
      'note': note,
      'contact_type': contactType,
      'date_created': dateCreated?.toIso8601String(),
      'last_updated': lastUpdated?.toIso8601String(),
      'service_type': serviceType,
    };
  }
}
