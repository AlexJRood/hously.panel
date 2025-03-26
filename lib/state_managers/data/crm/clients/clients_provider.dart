// lib/providers/ad_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/crm/clients/clients_view_page.dart';
import 'dart:convert';



final clientProvider = FutureProvider.family<UserContactModel, int>((ref, clientId) async {
  final response = await ApiServices.get(
    ref: ref,
    URLs.singleUserContacts('$clientId'),
    hasToken: true,
  );

  if (response != null && response.statusCode == 200) {
    final decodedBody = utf8.decode(response.data);
    final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
    return UserContactModel.fromJson(listingsJson as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load client');
  }
});

class ClientsFetcher extends ConsumerWidget {
  final int clientId;
  final String tagClientViewPop;
  final String activeSection;
  final String activeAd;

  const ClientsFetcher({
    required this.clientId,
    required this.tagClientViewPop,
    required this.activeAd,
    required this.activeSection,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adAsyncValue = ref.watch(clientProvider(clientId));

    return adAsyncValue.when(
      data: (client) {
        return ClientsViewPop(
          clientViewPop: client,
          tagClientViewPop: tagClientViewPop,
          activeSection: activeSection,
          activeAd: activeAd,
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.light,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}