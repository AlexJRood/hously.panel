class LeadStatus {
  final int id;
  final String statusName;
  final int statusIndex;
  final List<int> leadIndex;

  const LeadStatus({
    required this.id,
    required this.statusName,
    required this.statusIndex,
    required this.leadIndex,
  });

  factory LeadStatus.fromJson(Map<String, dynamic> json) {
    final leadIndex = json['lead_index'];
    return LeadStatus(
      id: json['id'],
      statusName: json['status_name'],
      statusIndex: json['status_index'],
      leadIndex: (leadIndex is List) ? List<int>.from(leadIndex) : [],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status_name': statusName,
      'status_index': statusIndex,
      'lead_index': leadIndex,
    };
  }

  LeadStatus copyWith({
    int? id,
    String? statusName,
    int? statusIndex,
    List<int>? leadIndex,
  }) {
    return LeadStatus(
      id: id ?? this.id,
      statusName: statusName ?? this.statusName,
      statusIndex: statusIndex ?? this.statusIndex,
      leadIndex: leadIndex ?? this.leadIndex,
    );
  }
}
