class TransactionStatus {
  final int id;
  final String statusName;
  final int statusIndex;
  final List<int> transactionIndex;

  const TransactionStatus({
    required this.id,
    required this.statusName,
    required this.statusIndex,
    required this.transactionIndex,
  });

  factory TransactionStatus.fromJson(Map<String, dynamic> json) {
    return TransactionStatus(
      id: json['id'],
      statusName: json['status_name'],
      statusIndex: json['status_index'],
      transactionIndex: List<int>.from(json['transaction_index'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status_name': statusName,
      'status_index': statusIndex,
      'transaction_index': transactionIndex,
    };
  }

  TransactionStatus copyWith({
    int? id,
    String? statusName,
    int? statusIndex,
    List<int>? transactionIndex,
  }) {
    return TransactionStatus(
      id: id ?? this.id,
      statusName: statusName ?? this.statusName,
      statusIndex: statusIndex ?? this.statusIndex,
      transactionIndex: transactionIndex ?? this.transactionIndex,
    );
  }
}
