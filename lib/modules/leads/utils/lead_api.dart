import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';

final leadFiltersProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final leadOrderingProvider = StateProvider<String?>((ref) => null);
final leadSearchProvider = StateProvider<String>((ref) => '');

final leadPageSizeProvider = StateProvider<int>((ref) => 17);


final paginatedLeadsProvider = FutureProvider.family.autoDispose<PaginatedLeadResponse, int>((ref, page) async {
  final filters = ref.watch(leadFiltersProvider);
  final search = ref.watch(leadSearchProvider);
  final ordering = ref.watch(leadOrderingProvider);
  final pageSize = ref.watch(leadPageSizeProvider);

  return await LeadService.fetchPaginatedLeads(
    ref: ref,
    page: page,
    pageSize: pageSize,
    filters: filters,
    search: search,
    ordering: ordering,
  );
});

final leadDetailsProvider = FutureProvider.family<Lead, int>((ref, leadId) async {
  return await LeadService.getLeadDetails(ref: ref, leadId: leadId);
});

class LeadService {
  static Future<PaginatedLeadResponse> fetchPaginatedLeads({
    required Ref ref,
    int page = 1,
    required int pageSize,
    Map<String, dynamic>? filters,
    String? search,
    String? ordering,
  }) async {
    final filterString = filters != null
        ? filters.entries
            .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
            .join('&')
        : '';

    final queryParams = [
      'page=$page',
      'page_size=$pageSize',
      if (ordering != null && ordering.isNotEmpty) 'ordering=$ordering',
      if (search != null && search.isNotEmpty) 'search=${Uri.encodeComponent(search)}',
      if (filterString.isNotEmpty) filterString,
    ].join('&');

    final response = await ApiServices.get(
      '${URLs.leads}?$queryParams',
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
