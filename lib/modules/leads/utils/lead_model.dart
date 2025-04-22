class PaginatedLeadResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Lead> results;

  PaginatedLeadResponse({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  factory PaginatedLeadResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedLeadResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((e) => Lead.fromJson(e))
          .toList(),
    );
  }
}

class Lead {
  final int id;
  final String name;
  final String? avatar;
  final String? companyName;

  final String? city;
  final String? state;
  final String? country;

  final String? label;
  final String? note;
  final String? lastNoteUpdate;

  final bool isLinkOpened;
  final String? followUpDate;

  final String? email;
  final String? aditionalEmail;
  final String? mailContent;
  final bool isMailSent;
  final String? mailSentDate;
  final bool isMailReceived;
  final String? receiveMailContent;
  final String? mailResponseDate;
  final bool isMailScheduled;
  final String? scheduledMailDate;

  final bool? hasAgreement;
  final String? agreementStatus;
  final int? leadStatus; // ID relacji
  final bool? isMeetingScheduled;

  final bool isRegister;
  final int? registerUser;

  final String? number;
  final String? aditionalNumber;
  final bool isNumberConfirmed;

  final String? source;
  final int? owner;

  final String createdAt;
  final String updatedAt;
  
  final List<LeadInteraction> interactions;

  Lead({
    required this.id,
    required this.name,
    this.avatar,
    this.companyName,
    this.city,
    this.state,
    this.country,
    this.label,
    this.note,
    this.lastNoteUpdate,
    required this.isLinkOpened,
    this.followUpDate,
    this.email,
    this.aditionalEmail,
    this.mailContent,
    required this.isMailSent,
    this.mailSentDate,
    required this.isMailReceived,
    this.receiveMailContent,
    this.mailResponseDate,
    required this.isMailScheduled,
    this.scheduledMailDate,
    this.hasAgreement,
    this.agreementStatus,
    this.leadStatus,
    this.isMeetingScheduled,
    required this.isRegister,
    this.registerUser,
    this.number,
    this.aditionalNumber,
    required this.isNumberConfirmed,
    this.source,
    this.owner,
    required this.createdAt,
    required this.updatedAt,
    this.interactions = const [],
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      companyName: json['company_name'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      label: json['label'],
      note: json['note'],
      lastNoteUpdate: json['last_note_update'],
      isLinkOpened: json['is_link_opened'] ?? false,
      followUpDate: json['follow_up_date'],
      email: json['email'],
      aditionalEmail: json['aditional_email'],
      mailContent: json['mail_content'],
      isMailSent: json['is_mail_sent'] ?? false,
      mailSentDate: json['mail_sent_date'],
      isMailReceived: json['is_mail_received'] ?? false,
      receiveMailContent: json['receive_mail_content'],
      mailResponseDate: json['mail_response_date'],
      isMailScheduled: json['is_mail_scheduled'] ?? false,
      scheduledMailDate: json['scheduled_mail_date'],
      hasAgreement: json['has_agreement'],
      agreementStatus: json['agreement_status'],
      leadStatus: json['lead_status'],
      isMeetingScheduled: json['is_meeting_scheduled'],
      isRegister: json['is_register'] ?? false,
      registerUser: json['register_user'],
      number: json['number'],
      aditionalNumber: json['aditional_number'],
      isNumberConfirmed: json['is_number_confirmed'] ?? false,
      source: json['source'],
      owner: json['owner'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],      

      interactions: (json['interactions'] as List)
          .map((e) => LeadInteraction.fromJson(e))
          .toList(),
    );
  }
}


class LeadInteraction {
  final String interactionType;
  final String? content;
  final String createdAt;

  LeadInteraction({
    required this.interactionType,
    this.content,
    required this.createdAt,
  });

  factory LeadInteraction.fromJson(Map<String, dynamic> json) {
    return LeadInteraction(
      interactionType: json['interaction_type'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }
}


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
