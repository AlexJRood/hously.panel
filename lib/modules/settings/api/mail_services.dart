import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/api_services/url.dart';

final emailAccountProvider = StateNotifierProvider<EmailAccountNotifier, AsyncValue<void>>((ref) {
  return EmailAccountNotifier();
});

class EmailAccountNotifier extends StateNotifier<AsyncValue<void>> {
  EmailAccountNotifier() : super(const AsyncValue.data(null));

  Future<void> saveEmailAccount(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final res = await ApiServices.post(
        URLs.emailAccount,
        hasToken: true,
        data: data,
      );
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)){
        state = const AsyncValue.data(null);
      } else {
        throw Exception("Błąd podczas zapisu");
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  
  Future<void> editEmailAccount(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final res = await ApiServices.patch(
        URLs.emailAccount,
        hasToken: true,
        data: data,
      );
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)){
        state = const AsyncValue.data(null);
      } else {
        throw Exception("Błąd podczas zapisu");
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}






