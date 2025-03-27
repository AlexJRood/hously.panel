import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/widgets/card/seller_model.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'dart:convert';



class SellerApiService {
  Future<Seller?> fetchSellerById(int sellerId,dynamic ref) async {
    try {
      final response = await ApiServices.get(ref:ref,URLs.singleSeller('$sellerId'));
      if (response != null && response.statusCode == 200) {        
        final decodedBody = utf8.decode(response.data);
        final listingsJson = json.decode(decodedBody) as Map<String, dynamic>;
        return Seller.fromJson(listingsJson);        
      }
    } catch (e) {
      // ignore: avoid_print
      print('Błąd podczas pobierania danych sprzedającego: $e');
    }
    return null;
  }
}

// Provider dla danych sprzedającego
final sellerProviderFamily =
    FutureProvider.autoDispose.family<Seller?, int>((ref, sellerId) async {
  final apiService = SellerApiService();
  return apiService.fetchSellerById(sellerId,ref);
});
