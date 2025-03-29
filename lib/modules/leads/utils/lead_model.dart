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
  final PhoneNumber? phones;
  final LeadEmail? emails;
  final List<LeadInteraction> interactions;
  final LeadAgreement? agreement;
  final LeadRegister? register;
  final LeadStatus? status;

  Lead({
    required this.id,
    required this.name,
    this.companyName,
    this.note,
    this.phones,
    this.emails,
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
      phones: json['phones'] != null 
        ? PhoneNumber.fromJson(json['phones']) 
        : null,  // Domyślny pusty obiekt

      emails: json['emails'] != null 
        ? LeadEmail.fromJson(json['emails']) 
        : null,  // Domyślny pusty obiekt

      interactions: (json['interactions'] as List)
          .map((e) => LeadInteraction.fromJson(e))
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
  final bool isConfirmed;

  PhoneNumber({
    required this.number,
    this.label,
    this.isConfirmed = false,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      number: json['number'],
      label: json['label'],
      isConfirmed: json['is_confirmed'] ?? false,
    );
  }
}


class LeadEmail {
  final String? mailContent;
  final String? mail;
  final bool isMailSent;
  final String? mailSentDate;
  final bool isMailReceived;
  final String? receiveMailContent;
  final String? mailResponseDate;

  LeadEmail({
    this.mailContent,
    this.mail,
    this.isMailSent = false,
    this.mailSentDate,
    this.isMailReceived = false,
    this.receiveMailContent,
    this.mailResponseDate,
  });

  factory LeadEmail.fromJson(Map<String, dynamic> json) {
    return LeadEmail(
      mail: json['mail'],
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
