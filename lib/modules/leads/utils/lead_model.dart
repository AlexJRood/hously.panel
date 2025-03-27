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
  final String? companyName;
  final String? note;
  final List<PhoneNumber> phones;
  final List<LeadEmail> emails;
  final List<LeadInteraction> interactions;
  final LeadAgreement? agreement;
  final LeadRegister? register;
  final LeadStatus? status;

  Lead({
    required this.id,
    required this.name,
    this.companyName,
    this.note,
    this.phones = const [],
    this.emails = const [],
    this.interactions = const [],
    this.agreement,
    this.register,
    this.status,
  });
factory Lead.fromJson(Map<String, dynamic> json) {
  return Lead(
    id: json['id'],
    name: json['name'],
    companyName: json['company_name'],
    note: json['note'],
    phones: (json['phones'] ?? [])
        .map<PhoneNumber>((e) => PhoneNumber.fromJson(e))
        .toList(),
    emails: (json['emails'] ?? [])
        .map<LeadEmail>((e) => LeadEmail.fromJson(e))
        .toList(),
    interactions: (json['interactions'] ?? [])
        .map<LeadInteraction>((e) => LeadInteraction.fromJson(e))
        .toList(),
    agreement: json['agreement'] != null
        ? LeadAgreement.fromJson(json['agreement'])
        : null,
    register: json['register'] != null
        ? LeadRegister.fromJson(json['register'])
        : null,
    status: json['status'] != null
        ? LeadStatus.fromJson(json['status'])
        : null,
  );
}

}


class PhoneNumber {
  final String number;
  final String? label;
  final bool isPrimary;

  PhoneNumber({
    required this.number,
    this.label,
    this.isPrimary = false,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      number: json['number'],
      label: json['label'],
      isPrimary: json['is_primary'] ?? false,
    );
  }
}


class LeadEmail {
  final String? mailContent;
  final bool isMailSent;
  final String? mailSentDate;
  final bool isMailReceived;
  final String? receiveMailContent;
  final String? mailResponseDate;

  LeadEmail({
    this.mailContent,
    this.isMailSent = false,
    this.mailSentDate,
    this.isMailReceived = false,
    this.receiveMailContent,
    this.mailResponseDate,
  });

  factory LeadEmail.fromJson(Map<String, dynamic> json) {
    return LeadEmail(
      mailContent: json['mail_content'],
      isMailSent: json['is_mail_sent'] ?? false,
      mailSentDate: json['mail_sent_date'],
      isMailReceived: json['is_mail_received'] ?? false,
      receiveMailContent: json['receive_mail_content'],
      mailResponseDate: json['mail_response_date'],
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


class LeadAgreement {
  final bool? hasAgreement;
  final String? agreementStatus;
  final bool? isMeetingScheduled;

  LeadAgreement({
    this.hasAgreement,
    this.agreementStatus,
    this.isMeetingScheduled,
  });

  factory LeadAgreement.fromJson(Map<String, dynamic> json) {
    return LeadAgreement(
      hasAgreement: json['has_agreement'],
      agreementStatus: json['agreement_status'],
      isMeetingScheduled: json['is_meeting_scheduled'],
    );
  }
}


class LeadRegister {
  final bool isRegister;
  final int? registerUser;

  LeadRegister({
    required this.isRegister,
    this.registerUser,
  });

  factory LeadRegister.fromJson(Map<String, dynamic> json) {
    return LeadRegister(
      isRegister: json['is_register'] ?? false,
      registerUser: json['register_user'],
    );
  }
}


class LeadStatus {
  final int id;
  final String statusName;
  final int statusIndex;

  LeadStatus({
    required this.id,
    required this.statusName,
    required this.statusIndex,
  });

  factory LeadStatus.fromJson(Map<String, dynamic> json) {
    return LeadStatus(
      id: json['id'],
      statusName: json['status_name'],
      statusIndex: json['status_index'],
    );
  }
}
