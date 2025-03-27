import 'package:equatable/equatable.dart';

class BookingFormModel extends Equatable {
  final String id;
  final String fieldName;
  final bool isRequired;
  final bool isDeletable;
  final bool isEditable;

  // Constructor
  const BookingFormModel({
    required this.id,
    required this.fieldName,
    required this.isRequired,
    required this.isDeletable,
    required this.isEditable,
  });

  // Factory constructor to create an instance from a JSON map
  factory BookingFormModel.fromJson(Map<String, dynamic> json) {
    return BookingFormModel(
      id: json['id'] as String,
      fieldName: json['fieldName'] as String,
      isRequired: json['isRequired'] as bool,
      isDeletable: json['isDeletable'] as bool,
      isEditable: json['isEditable'] as bool,
    );
  }

  // Method to convert an instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fieldName': fieldName,
      'isRequired': isRequired,
      'isDeletable': isDeletable,
      'isEditable': isEditable,
    };
  }

  // Copy with method for immutability
  BookingFormModel copyWith({
    String? id,
    String? fieldName,
    bool? isRequired,
    bool? isDeletable,
    bool? isEditable,
  }) {
    return BookingFormModel(
      id: id ?? this.id,
      fieldName: fieldName ?? this.fieldName,
      isRequired: isRequired ?? this.isRequired,
      isDeletable: isDeletable ?? this.isDeletable,
      isEditable: isEditable ?? this.isEditable,
    );
  }

  // Equatable props
  @override
  List<Object?> get props =>
      [id, fieldName, isRequired, isDeletable, isEditable];

  @override
  bool get stringify => true; // This makes toString() more readable.
}
