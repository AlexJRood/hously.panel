import 'package:equatable/equatable.dart';
import 'package:hously_flutter/enums/event/notification_period_enum.dart';

class Reminder extends Equatable {
  final String id;
  final int counter;
  final NotificationPeriodEnum periodEnum;

  const Reminder({
    required this.id,
    required this.counter,
    required this.periodEnum,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'counter': counter,
        'time': periodEnum.name,
      };

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      counter: json['counter'],
      periodEnum: NotificationPeriodEnum.fromString(json['periodEnum']),
    );
  }

  @override
  List<Object?> get props => [id, counter, periodEnum];

  Reminder copyWith({
    String? id,
    int? counter,
    NotificationPeriodEnum? periodEnum,
  }) =>
      Reminder(
        id: id ?? this.id,
        counter: counter ?? this.counter,
        periodEnum: periodEnum ?? this.periodEnum,
      );
}
