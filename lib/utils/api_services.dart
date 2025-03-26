// ignore_for_file: avoid_web_libraries_in_flutter
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';

import '../platforms/html_utils_stub.dart'
if(dart.library.html) '../platforms/html_utils_web.dart';
import '../state_managers/data/internet_checker/Internet_checker_provider.dart';

class ApiServices {
  static final _dio = Dio();
  static final _secureStorage = SecureStorage();
  static String? token;

  static Future<void> init(WidgetRef? ref) async {
    token = await _secureStorage.getToken();

    if (ref != null) ref.read(authProvider.notifier).setToken(token);
    debugPrint('Mahdi: check token: $token');
    if (ref != null) ref.read(userStateProvider.notifier).fetchUser(ref);
  }

  static bool isUserLoggedIn() => (token != null);

  static Future<Response?> get(
    
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    bool hasToken = false,
    ResponseType? responseType,
    required dynamic ref,
  }) async {
    try {
      final newHeaders = headers ?? {};
      if (hasToken) {
        token ??= await _secureStorage.getToken();
        if (token != null) {
          newHeaders['Authorization'] = 'Token $token';
        }
      }

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
            headers: newHeaders,
            responseType: responseType ?? ResponseType.bytes),
      );
      return response;
    } catch (e) {
      // If error is network-related, add to the failed API queue
      if (e is DioException && e.type == DioExceptionType.connectionError) {
        ref.read(failedApiProvider.notifier).addRequest(
              FailedApiRequest(
                url: url,
                headers: headers,
                queryParameters: queryParameters,
                hasToken: hasToken,
              ),
            );
        ref.watch(failedApiProvider);
      }

      return null;
    }
  }

  static Future<Response?> post(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    bool hasToken = false,
    FormData? formData,
  }) async {
    try {
      final newHeaders = headers ?? {};
      if (hasToken) {
        token ??= await _secureStorage.getToken();
        if (token != null) {
          newHeaders['Authorization'] = 'Token $token';
        }
      }
      final response = await _dio.post(
        url,
        options: Options(headers: newHeaders),
        data: data ?? formData,
      );
      return response;
    } catch (e) {
      debugPrint('Dio post error: $e');
      debugPrint('Dio post error: $url');
      return null;
    }
  }

  static Future<Response?> put(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    bool hasToken = false,
    FormData? formData,
  }) async {
    try {
      final newHeaders = headers ?? {};
      if (hasToken) {
        token ??= await _secureStorage.getToken();
        if (token != null) {
          newHeaders['Authorization'] = 'Token $token';
        }
      }
      final response = await _dio.put(
        url,
        options: Options(headers: newHeaders),
        data: data ?? formData,
      );
      return response;
    } catch (e) {
      debugPrint('Dio put error: $e');
      return null;
    }
  }

  static Future<Response?> patch(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    bool hasToken = false,
  }) async {
    try {
      final newHeaders = headers ?? {};
      if (hasToken) {
        token ??= await _secureStorage.getToken();
        if (token != null) {
          newHeaders['Authorization'] = 'Token $token';
        }
      }
      final response = await _dio.patch(
        url,
        options: Options(headers: newHeaders),
        data: data,
      );
      return response;
    } catch (e) {
      debugPrint('Dio patch error: $e');
      return null;
    }
  }

  static Future<Response?> delete(
    String url, {
    Map<String, String>? headers,
    bool hasToken = false,
  }) async {
    try {
      final newHeaders = headers ?? {};
      if (hasToken) {
        token ??= await _secureStorage.getToken();
        if (token != null) {
          newHeaders['Authorization'] = 'Token $token';
        }
      }
      final response =
          await _dio.delete(url, options: Options(headers: newHeaders));
      return response;
    } catch (e) {
      debugPrint('Dio delete error: $e');
      return null;
    }
  }



  Future<Response> postWithCsrf(
      String endpoint, Map<String, dynamic> data) async {
    final csrfToken = getCsrfTokenFromCookies();

    _dio.options.headers['X-CSRFToken'] = csrfToken;
    return await _dio.post(endpoint, data: data);
  }
}

class IsUserLoggedinNotifier extends StateNotifier<bool> {
  IsUserLoggedinNotifier() : super(false);

  Future<void> setToken(String? token) async {
    final _secureStorage = SecureStorage();
    final fetchedToken = await _secureStorage.getToken(); // Oczekujemy na token
    if (fetchedToken != null) {
      state = true; // Użytkownik zalogowany
    } else {
      state = false; // Użytkownik wylogowany
    }
  }
}

final authProvider = StateNotifierProvider<IsUserLoggedinNotifier, bool>((ref) {
  return IsUserLoggedinNotifier();
});
