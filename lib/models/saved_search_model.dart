class SavedSearchModel {
  final int id;
  // final int clientId;
  final String title;
  final String description;
  final String tags;
  final String searchQuery;
  final Map<String, dynamic> filters;
  final int lastCount;
  final String lastChecked;
  final String createdAt;
  final String updatedAt;
  final String avatar;

  const SavedSearchModel({
    required this.id,
    // required this.clientId,
    required this.title,
    required this.description,
    required this.tags,
    required this.searchQuery,
    required this.filters,
    required this.lastCount,
    required this.lastChecked,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
  });

  factory SavedSearchModel.fromJson(Map<String, dynamic> json) {
    return SavedSearchModel(
      id: json['id'],
      // clientId: json['client_id'],
      title: json['title'],
      description: json['description'],
      tags: json['tags'] ?? '',
      searchQuery: json['search_query'] ?? '',
      filters: json['filters'] ?? '',
      lastCount: json['last_count']?? '',
      lastChecked: json['last_checked']?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      avatar: json['avatar'] ?? 'assets/images/landingpage.webp',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'client_id': clientId,
      'title': title,
      'description': description,
      'tags': tags,
      'search_query': searchQuery,
      'filters': filters,
      'last_count': lastCount,
      'last_checked': lastChecked,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'avatar': avatar,
    };
  }
}
