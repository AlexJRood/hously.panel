import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';

final transactionTypeProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  try {
    final response = await ApiServices.get(
      ref: ref,
      URLs.transactionSummary,
      hasToken: true,
    );

    if (response == null || response.data == null) {
      throw Exception("No response or invalid data from API");
    }

    final decodedBody = utf8.decode(response.data);
    final parsedData = json.decode(decodedBody);

    if (parsedData is Map<String, dynamic>) {
      // Weryfikujemy, czy dane zawierają klucze 'expenses' i 'revenues'
      final expenses = List<Map<String, dynamic>>.from(
          parsedData['expenses'] ?? const []);
      final revenues = List<Map<String, dynamic>>.from(
          parsedData['revenues'] ?? const []);

      return {
        "expenses": expenses,
        "revenues": revenues,
      };
    } else {
      throw Exception("Unexpected data structure");
    }
  } catch (error) {
    throw Exception("Failed to fetch transaction summary: $error");
  }
});
