import 'package:flutter_riverpod/flutter_riverpod.dart';

final mailSortProvider = StateProvider<String>((ref) => 'received_at_desc');
final mailTypeProvider = StateProvider<String>((ref) => 'all');
final mailSearchProvider = StateProvider<String>((ref) => '');
final mailPageProvider = StateProvider<int>((ref) => 1);
final mailPageSizeProvider = StateProvider<int>((ref) => 10);



class EmailFilterParams {
  final String? searchQuery;
  final bool? isOutgoing;
  final int? page;
  final int? pageSize;
  final String? ordering; // np. -received_at, subject

  EmailFilterParams({
    this.searchQuery,
    this.isOutgoing,
    this.page,
    this.pageSize,
    this.ordering,
  });
}
