class EmailMessage {
  final int id;
  final String subject;
  final String sender;
  final List<String> recipients;
  final String body;
  final String? receivedAt;
  final String? sentAt;
  final bool isOutgoing;

  EmailMessage({
    required this.id,
    required this.subject,
    required this.sender,
    required this.recipients,
    required this.body,
    required this.receivedAt,
    required this.sentAt,
    required this.isOutgoing,
  });

  factory EmailMessage.fromJson(Map<String, dynamic> json) {
    return EmailMessage(
      id: json['id'],
      subject: json['subject'] ?? '',
      sender: json['sender'] ?? '',
      recipients: List<String>.from(json['recipients'] ?? []),
      body: json['body'] ?? '',
      receivedAt: json['received_at'],
      sentAt: json['sent_at'],
      isOutgoing: json['is_outgoing'] ?? false,
    );
  }
}


class PaginatedEmailResponse {
  final List<EmailMessage> results;
  final int count;

  PaginatedEmailResponse({required this.results, required this.count});

  factory PaginatedEmailResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedEmailResponse(
      results: (json['results'] as List)
          .map((e) => EmailMessage.fromJson(e))
          .toList(),
      count: json['count'],
    );
  }
}
