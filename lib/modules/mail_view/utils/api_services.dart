
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/modules/mail_view/utils/mail_models.dart';
import 'package:hously_flutter/modules/mail_view/utils/mail_filters.dart';



final emailDetailsProvider = FutureProvider.family<EmailMessage, int>((ref, emailId) async {
  return await EmailService.getEmailDetails(ref: ref, emailId: emailId);
});

final emailsByLeadProvider = FutureProvider.family<PaginatedEmailResponse, int>((ref, leadId) async {
  final response = await ApiServices.get(
    '${URLs.emails}?lead=$leadId',
    hasToken: true,
    ref: ref,
  );

  

  if (response != null && response.statusCode == 200) {
    final decoded = json.decode(utf8.decode(response.data));
    return PaginatedEmailResponse.fromJson(decoded);
  } else {
    throw Exception('Nie udało się pobrać maili dla leada $leadId');
  }
});

final syncEmailsProvider = FutureProvider.autoDispose<void>((ref) async {
  final response = await ApiServices.post(
    '${URLs.emails}sync/',
    hasToken: true,
  );

  if (response == null || response.statusCode! >= 400) {
    throw Exception('Nie udało się zsynchronizować wiadomości e-mail');
  }
});



final filteredEmailsProvider = FutureProvider.autoDispose<PaginatedEmailResponse>((ref) async {
  final type = ref.watch(mailTypeProvider);
  final search = ref.watch(mailSearchProvider);
  final page = ref.watch(mailPageProvider);
  final pageSize = ref.watch(mailPageSizeProvider);
  final sort = ref.watch(mailSortProvider);
  String? ordering;

  switch (sort) {
    case 'received_at_desc':
      ordering = '-received_at';
      break;
    case 'received_at_asc':
      ordering = 'received_at';
      break;
    case 'subject_asc':
      ordering = 'subject';
      break;
    case 'subject_desc':
      ordering = '-subject';
      break;
  }

  return await EmailService.fetchFilteredEmails(
    ref: ref,
    params: EmailFilterParams(
      searchQuery: search.isNotEmpty ? search : null,
      isOutgoing: type == 'sent' ? true : type == 'inbox' ? false : null,
      page: page,
      pageSize: pageSize,
      ordering: ordering,
    ),
  );

});

class EmailService {

static Future<PaginatedEmailResponse> fetchFilteredEmails({
  required Ref ref,
  required EmailFilterParams params,
}) async {
  final queryParams = {
    if (params.searchQuery != null) 'search': params.searchQuery!,
    if (params.isOutgoing != null) 'is_outgoing': params.isOutgoing! ? 'true' : 'false',
    if (params.page != null) 'page': params.page.toString(),
    if (params.pageSize != null) 'page_size': params.pageSize.toString(),
    if (params.ordering != null) 'ordering': params.ordering!, // ✅ TU DODAJ
  };

  final uri = Uri.parse(URLs.emails).replace(queryParameters: queryParams);
  final response = await ApiServices.get(uri.toString(), hasToken: true, ref: ref);

  if (response != null && response.statusCode == 200) {
    final decoded = json.decode(utf8.decode(response.data));
    return PaginatedEmailResponse.fromJson(decoded);
  } else {
    throw Exception('Nie udało się pobrać wiadomości');
  }
}


  static Future<EmailMessage> getEmailDetails({
    required Ref ref,
    required int emailId,
  }) async {
    final response = await ApiServices.get(
      '${URLs.emails}$emailId/',
      hasToken: true,
      ref: ref,
    );

    if (response != null && response.statusCode == 200 && response.data != null) {
      final decoded = json.decode(utf8.decode(response.data));
      return EmailMessage.fromJson(decoded);
    } else {
      throw Exception('Nie udało się pobrać szczegółów maila');
    }
  }



    static Future<void> sendEmail({
    required WidgetRef ref,
    required Map<String, dynamic> data,
  }) async {
    final response = await ApiServices.post(
      '${URLs.emails}send/', // lub `${URLs.emails}send/` jeśli używasz innego prefixu
      hasToken: true,
      data: data,
    );

    if (response == null || response.statusCode! >= 400) {
      throw Exception('Nie udało się wysłać wiadomości');
    }
  }


final searchEmailsProvider = FutureProvider.family
    .autoDispose<PaginatedEmailResponse, String>((ref, query) async {
  final response = await ApiServices.get(
    '${URLs.emailSearch}search/?search=$query',
    hasToken: true,
    ref: ref,
  );

  if (response != null && response.statusCode == 200) {
    final decoded = json.decode(utf8.decode(response.data));
    return PaginatedEmailResponse.fromJson(decoded);
  } else {
    throw Exception('Nie udało się wyszukać wiadomości.');
  }
});

}



