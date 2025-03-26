import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/article_model.dart';
import 'package:hously_flutter/utils/api_services.dart';

// Definicja providera
final articleProvider = FutureProvider<List<Article>>((ref) async {
  final response = await ApiServices.get(URLs.apiArticles,ref: ref);
  if (response != null && response.statusCode == 200) {
    // Dekodowanie odpowiedzi z użyciem UTF-8
    final responseBody = utf8.decode(response.data);
    List<dynamic> data = (json.decode(responseBody)['results']) as List;
    return data
        .map<Article>((json) => Article.fromJson(json as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load articles');
  }
});
