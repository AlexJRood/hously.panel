import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/user_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'dart:convert';

class AuthStateNotifier extends StateNotifier<bool> {
  AuthStateNotifier() : super(false) {
    _checkLoggedIn();
  }

  final SecureStorage _secureStorage = SecureStorage();

  void _checkLoggedIn() async {
    final token = await _secureStorage.getToken();
    state = token != null;
  }

  Future<void> logIn(WidgetRef ref) async {
    state = true;
  }

  Future<void> logOut(WidgetRef ref) async {
    await _secureStorage.removeToken();
    ApiServices.token = null;

    state = false;
    ref.invalidate(userStateProvider);
    ref.invalidate(userProvider);
    ref.invalidate(authStateProvider);
  }
}

final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  return AuthStateNotifier();
});

final userProvider = FutureProvider.autoDispose<UserModel?>((ref) async {
  // Nasłuchiwanie stanu logowania
  final isLoggedIn = ref.watch(authProvider);

  if (isLoggedIn) {
    final token = ApiServices.token;
    if (token != null) {
      final apiService = ApiServiceUser();
      final user = await apiService.fetchUser(token, ref);

      if (user != null) {
        return user;
      }
    }
  }
  return null;
});

class ApiServiceUser {
  Future<UserModel?> fetchUser(String token, dynamic ref) async {
    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.userProfile,
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        final decodedBody = utf8.decode(response.data);
        final listingsJson = json.decode(decodedBody) as Map<String, dynamic>;
        return UserModel.fromJson(listingsJson);
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  Future<UserModel?> fetchUserById(
      String token, int userId, dynamic ref) async {
    try {
      final response = await ApiServices.get(
        ref: ref,
        '${URLs.userProfile}$userId/',
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        final decodedBody = utf8.decode(response.data);
        final listingsJson = json.decode(decodedBody) as Map<String, dynamic>;
        return UserModel.fromJson(listingsJson);
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }
}

class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier(dynamic ref) : super(null) {
    fetchUser(ref);
  }

  Future<void> fetchUser(dynamic ref) async {
    if (ApiServices.token != null) {
      final apiService = ApiServiceUser();
      state = await apiService.fetchUser(ApiServices.token!, ref);
    }
  }

  void updateUserFromJson(Map<String, dynamic> json) {
    state = UserModel.fromJson(json);
  }

  void clearUser() {
    state = null;
  }
}

final userStateProvider =
    StateNotifierProvider<UserStateNotifier, UserModel?>((ref) {
  return UserStateNotifier(ref);
});

final userProviderFamily =
    FutureProvider.autoDispose.family<UserModel?, int>((ref, sellerId) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (isUserLoggedIn) {
    if (ApiServices.token != null) {
      final apiService = ApiServiceUser();
      return apiService.fetchUserById(ApiServices.token!, sellerId, ref);
    }
  }
  return null;
});

final isProProvider = Provider<bool>((ref) {
  final user = ref.watch(userStateProvider);
  return user?.isPro ?? true; //change to production
});
