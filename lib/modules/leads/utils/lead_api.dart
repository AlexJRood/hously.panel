import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';

final paginatedLeadsProvider = FutureProvider.family
    .autoDispose<PaginatedLeadResponse, int>((ref, page) async {
  return await LeadService.fetchPaginatedLeads(ref: ref, page: page);
});

final leadDetailsProvider = FutureProvider.family<Lead, int>((ref, leadId) async {
  return await LeadService.getLeadDetails(ref: ref, leadId: leadId);
});


class LeadService {
  // Paginowana lista leadów
  static Future<PaginatedLeadResponse> fetchPaginatedLeads({
    required Ref ref,
    int page = 1,
    int pageSize = 10,
  }) async {
    final response = await ApiServices.get(
      '${URLs.leads}?page=$page&page_size=$pageSize',
      hasToken: true,
      ref: ref,
    );

    if (response != null && response.statusCode == 200) {
      final decoded = json.decode(utf8.decode(response.data));
      return PaginatedLeadResponse.fromJson(decoded);
    } else {
      throw Exception('Nie udało się pobrać leadów');
    }
  }

  // Pobranie szczegółów leada
  static Future<Lead> getLeadDetails({
    required Ref ref,
    required int leadId,
  }) async {
    final response = await ApiServices.get(
      '${URLs.leads}$leadId/',
      hasToken: true,
      ref: ref,
    );

    if (response != null && response.statusCode == 200 && response.data != null) {
      final decoded = json.decode(utf8.decode(response.data));
      return Lead.fromJson(decoded);
    } else {
      throw Exception('Nie udało się pobrać szczegółów leada');
    }
  }

  

  // Edycja (PATCH)
  static Future<void> updateLead({
    required WidgetRef ref,
    required int leadId,
    required Map<String, dynamic> data,
  }) async {
    final response = await ApiServices.patch(
      '${URLs.leads}$leadId/',
      hasToken: true,
      data: data,
    );

    if (response == null || response.statusCode! >= 400) {
      throw Exception('Nie udało się zaktualizować leada');
    }
  }



  // Usuwanie leada
  static Future<void> deleteLead({
    required WidgetRef ref,
    required int leadId,
  }) async {
    final response = await ApiServices.delete(
      hasToken: true,
      '${URLs.leads}$leadId/',
    );

    if (response == null || response.statusCode! >= 400) {
      throw Exception('Nie udało się usunąć leada');
    }
  }

  


  // Dodawanie leada
  static Future<Lead> createLead({
    required WidgetRef ref,
    required Map<String, dynamic> data,
  }) async {
    final response = await ApiServices.post(
      URLs.leads,
      hasToken: true,
      data: data,
    );

    if (response != null && response.statusCode == 201) {
      final jsonData = json.decode(utf8.decode(response.data));
      return Lead.fromJson(jsonData);
    } else {
      throw Exception('Nie udało się utworzyć leada');
    }
  }
}
