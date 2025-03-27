import 'package:hously_flutter/api_services/url.dart';

class UserModel {
  final String userId;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? accountType;
  final bool? acceptTerms;
  final bool? acceptMarketing;
  final String? subscriptionLevel;
  final bool? proAccountVerified;
  final bool? isPro;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.avatarUrl,
    this.accountType,
    this.acceptTerms,
    this.acceptMarketing,
    this.subscriptionLevel,
    this.proAccountVerified,
    this.isPro = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] ?? {};
    String? avatarPath = profile['avatar'];
    String? fullAvatarUrl;

    if (avatarPath != null) {
      if (avatarPath.startsWith('/media/avatars')) {
        fullAvatarUrl = '${URLs.baseUrl}$avatarPath';
      } else {
        fullAvatarUrl = avatarPath.replaceFirst('/media/', '');
      }
    }

    return UserModel(
      userId: json['id'].toString(),
      username: json['username'] ?? 'Nieznany',
      email: json['email'] ?? 'brak@email.com',
      firstName: json['first_name'] ?? 'Imię',
      lastName: json['last_name'] ?? 'Nazwisko',
      phoneNumber: profile['phone_number'],
      avatarUrl: fullAvatarUrl,
      accountType: profile['account_type'],
      acceptTerms: profile['accept_terms'] ?? false,
      acceptMarketing: profile['accept_marketing'] ?? false,
      subscriptionLevel: profile['subscription_level'],
      proAccountVerified: profile['pro_account_verified'] ?? false,
    );
  }
}
