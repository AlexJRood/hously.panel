import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/models/sale_document_model.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/models/sale_document_response_model.dart';
import 'package:hously_flutter/utils/api_services.dart';

class SalesDocumentNotifier extends StateNotifier<List<SaleDocument>> {
  SalesDocumentNotifier() : super([]);

  Future<void> fetchSaleDocument(dynamic ref) async {
    try {
      final response = await ApiServices.get(
        URLs.fetchSaleDocument,
        ref: ref,
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        final responseString = utf8.decode(response.data);
        final jsonResponse = jsonDecode(responseString);
        final docResponse = SaleDocumentResponse.fromJson(jsonResponse);
        state = docResponse.results;
        print('Sale documents fetched successfully. Count: ${state.length}');
        for (var doc in state) {
          print(
              'Document ID: ${doc.id}, Name: ${doc.documentName}, File: ${doc.fileUrl}');
        }
      } else {
        print(
            'Sale documents fetch failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error fetching sale documents: $e');
    }
  }

  Future<void> createSaleDocument(dynamic ref) async {
    try {
      final dummyBytes = <int>[0x89, 0x50, 0x4E, 0x47];

      final formData = FormData.fromMap({
        'sale': '1',
        'document_name': 'file',
        'file': MultipartFile.fromBytes(
          dummyBytes,
          filename: 'dummy.png',
        ),
      });

      final response = await ApiServices.post(
        URLs.createSaleDocument,
        hasToken: true,
        formData: formData,
      );

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        print('Sale document created successfully');
        await fetchSaleDocument(ref);
      } else {
        print(
            'Sale document creation failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error creating sale document: $e');
    }
  }
}

final salesDocumentProvider =
    StateNotifierProvider<SalesDocumentNotifier, List<SaleDocument>>(
  (ref) => SalesDocumentNotifier(),
);
