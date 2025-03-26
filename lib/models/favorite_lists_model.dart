class FavoriteListModel {
  final int id;
  final String name;
  final int clientId;

  const FavoriteListModel({
    required this.id,
    required this.name,
    required this.clientId,
  });

  factory FavoriteListModel.fromJson(Map<String, dynamic> json) {
    return FavoriteListModel(
      id: json['id'],
      name: json['name'],
      clientId: json['client'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'client': clientId,
    };
  }
}
