
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/utils/api_services.dart';



final apiProviderUserContactsStatuses = Provider<ApiServiceUserContactsStatuses>((ref) => ApiServiceUserContactsStatuses());

class ApiServiceUserContactsStatuses{
  ApiServiceUserContactsStatuses();

  Future<void> updateColumnIndexes(List<int> columnIds) async {
    final response = await ApiServices.patch(
      URLs.userContactStatusUpdateStatusesIndexes,
      data: {'columns': columnIds},
      hasToken: true,
    );

    if (response != null && response.statusCode != 200) {
      throw Exception('Failed to update column indexes');
    }
  }

  Future<void> updateUserContactStatuses(
      List<Map<String, dynamic>> statuses) async {
    final response = await ApiServices.patch(
      URLs.userContactStatusUpdateColumns,
      data: {'statuses': statuses},
      hasToken: true,
    );

    if (response != null && response.statusCode != 200) {
      throw Exception('Failed to update userContact statuses');
    }
  }
}
