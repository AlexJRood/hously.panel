// city_model.dart

class City {
  final String city;
  final Map<String, String>? districts;

  City({required this.city, this.districts});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      city: json['city'],
      districts: (json['districts'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as String),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'districts': districts,
    };
  }
}
class RecentCity {
  final String name;
  final City cityInfo;

  RecentCity({required this.name, required this.cityInfo});
}
