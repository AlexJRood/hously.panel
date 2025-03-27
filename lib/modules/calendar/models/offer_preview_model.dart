import 'package:equatable/equatable.dart';

class OfferPreview extends Equatable {
  final String id;
  final String keyMetrics;
  final String mainPhotoUrl;

  const OfferPreview({
    required this.id,
    required this.keyMetrics,
    required this.mainPhotoUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'keyMetrics': keyMetrics,
        'mainPhotoUrl': mainPhotoUrl,
      };

  factory OfferPreview.fromJson(Map<String, dynamic> json) {
    return OfferPreview(
      id: json['id'],
      keyMetrics: json['keyMetrics'],
      mainPhotoUrl: json['mainPhotoUrl'],
    );
  }

  @override
  List<Object?> get props => [id, keyMetrics, mainPhotoUrl];
}
