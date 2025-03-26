import 'package:hously_flutter/models/crm/clients_model.dart';

class CrmExpensesDownloadModel {
  final int id;
  final String? name;
  final String amount;
  final String currency;
  final String? transactionType;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final DateTime? paymentDate;
  final bool isPayed;
  final bool isMonthlyPayment;
  final DateTime? whenMonthlyPaymentIsOver;
  final String? note;
  final String? invoiceNumber;
  final Map<String, dynamic>? invoiceData;
  final List<dynamic> documents;
  final List<dynamic> tags;
  final List<dynamic> paymentMethods;
  final String? status;
  final int? objectId;
  final int? contractor;
  final dynamic clients;
  final String? contentType;

  const CrmExpensesDownloadModel({
    required this.id,
    this.name,
    required this.amount,
    required this.currency,
    this.transactionType,
    required this.dateCreate,
    required this.dateUpdate,
    this.paymentDate,
    required this.isPayed,
    required this.isMonthlyPayment,
    this.whenMonthlyPaymentIsOver,
    this.note,
    this.invoiceNumber,
    this.invoiceData,
    required this.documents,
    required this.tags,
    required this.paymentMethods,
    this.status,
    this.objectId,
    this.contractor,
    this.clients,
    this.contentType,
  });

  factory CrmExpensesDownloadModel.fromJson(Map<String, dynamic> json) {
    return CrmExpensesDownloadModel(
      id: json['id'] ?? 0,
      name: json['name'],
      amount: json['amount']?.toString() ?? '0.0',
      currency: json['currency'] ?? '',
      transactionType: json['transaction_type'],
      dateCreate: DateTime.parse(json['date_create']),
      dateUpdate: DateTime.parse(json['date_update']),
      paymentDate: json['payment_date'] != null
          ? DateTime.parse(json['payment_date'])
          : null,
      isPayed: json['is_payed'] ?? false,
      isMonthlyPayment: json['is_monthly_payment'] ?? false,
      whenMonthlyPaymentIsOver: json['when_monthly_payment_is_over'] != null
          ? DateTime.parse(json['when_monthly_payment_is_over'])
          : null,
      note: json['note'],
      invoiceNumber: json['invoice_number'],
      invoiceData: json['invoice_data'] is Map<String, dynamic>
          ? json['invoice_data']
          : {},
      documents: json['documents'] ?? [],
      tags: json['tags'] ?? [],
      paymentMethods: json['payment_methods'] ?? [],
      status: json['status'],
      objectId: json['object_id'],
      contractor: json['contractor'],
      clients: json['clients'],
      contentType: json['content_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'currency': currency,
      'transaction_type': transactionType,
      'date_create': dateCreate.toIso8601String(),
      'date_update': dateUpdate.toIso8601String(),
      'payment_date': paymentDate?.toIso8601String(),
      'is_payed': isPayed,
      'is_monthly_payment': isMonthlyPayment,
      'when_monthly_payment_is_over':
          whenMonthlyPaymentIsOver?.toIso8601String(),
      'note': note,
      'invoice_number': invoiceNumber,
      'invoice_data': invoiceData,
      'documents': documents,
      'tags': tags,
      'payment_methods': paymentMethods,
      'status': status,
      'object_id': objectId,
      'contractor': contractor,
      'clients': clients,
      'content_type': contentType,
    };
  }
}
