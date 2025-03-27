import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/calendar/enums/event/guest_permission_enum.dart';

class Guest extends Equatable {
  final String id;
  final String emailAddress;
  final bool isOrganizer;
  final Color guestColor;
  final List<GuestPermissionsEnum> guestPermissions;

  const Guest({
    required this.id,
    required this.emailAddress,
    required this.isOrganizer,
    required this.guestColor,
    required this.guestPermissions,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'emailAddress': emailAddress,
        'isOrganizer': isOrganizer,
        'guestColor': guestColor,
        'guestPermissions': guestPermissions,
      };

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      id: json['id'],
      emailAddress: json['emailAddress'],
      isOrganizer: json['isOrganizer'],
      guestColor: json['guestColor'],
      guestPermissions:
          List<GuestPermissionsEnum>.from(json['guestPermissions']),
    );
  }

  @override
  List<Object?> get props =>
      [id, emailAddress, isOrganizer, guestColor, guestPermissions];
}
