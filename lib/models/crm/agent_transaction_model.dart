import 'package:hously_flutter/models/crm/clients_model.dart';

class AgentTransactionModel {
  final int id;
  final UserContactModel client;
  final bool isSeller;
  final bool isBuyer;
  final String name;
  final String commission;
  final String amount;
  final String currency;
  final String transactionType;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final DateTime? paymentDate;
  final bool isMonthlyPayment;
  final DateTime? whenMonthlyPaymentIsOver;
  final String? note;
  final String? transactionName;
  final String? invoiceNumber;
  final Map<String, dynamic>? invoiceData;
  final bool sendInvoiceEmail;
  final List<dynamic> documents;
  final List<dynamic> tags;
  final List<dynamic> paymentMethods;
  final String? status;
  final bool isPayed;
  final String? country;
  final String? city;
  final String? street;
  final String? postalCode;
  final String? taxAmount;
  final int? draft;
  final int createdBy;

  const AgentTransactionModel({
    required this.id,
    required this.client,
    required this.isSeller,
    required this.isBuyer,
    required this.name,
    required this.commission,
    required this.amount,
    required this.currency,
    required this.transactionType,
    required this.dateCreate,
    required this.dateUpdate,
    this.paymentDate,
    required this.isMonthlyPayment,
    this.whenMonthlyPaymentIsOver,
    this.note,
    this.transactionName,
    this.invoiceNumber,
    this.invoiceData,
    required this.sendInvoiceEmail,
    required this.documents,
    required this.tags,
    required this.paymentMethods,
    this.status,
    required this.isPayed,
    this.country,
    this.city,
    this.street,
    this.postalCode,
    this.taxAmount,
    this.draft,
    required this.createdBy,
  });

  factory AgentTransactionModel.fromJson(Map<String, dynamic> json) {
    return AgentTransactionModel(
      id: json['id'],
      client: UserContactModel.fromJson(json['client']),
      isSeller: json['is_seller'] ?? false,
      isBuyer: json['is_buyer'] ?? false,
      name: json['name'] ?? 'Unknown Transaction',
      commission: json['commission'] ?? '0.00',
      amount: json['amount'] ?? '0.00',
      currency: json['currency'] ?? 'USD',
      transactionType: json['transaction_type'] ?? 'Unknown',
      dateCreate: DateTime.parse(json['date_create']),
      dateUpdate: DateTime.parse(json['date_update']),
      paymentDate: json['payment_date'] != null
          ? DateTime.parse(json['payment_date'])
          : null,
      isMonthlyPayment: json['is_monthly_payment'] ?? false,
      whenMonthlyPaymentIsOver: json['when_monthly_payment_is_over'] != null
          ? DateTime.parse(json['when_monthly_payment_is_over'])
          : null,
      note: json['note'],
      transactionName: json['transaction_name'],
      invoiceNumber: json['invoice_number'],
      invoiceData: json['invoice_data'] is Map<String, dynamic>
          ? json['invoice_data']
          : {},
      sendInvoiceEmail: json['send_invoice_email'] ?? false,
      documents: json['documents'] ?? [],
      tags: json['tags'] ?? [],
      paymentMethods: json['payment_methods'] ?? [],
      status: json['status'],
      isPayed: json['is_payed'] ?? false,
      country: json['country'],
      city: json['city'],
      street: json['street'],
      postalCode: json['postal_code'],
      taxAmount: json['tax_amount'],
      draft: json['draft'],
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client': client.toJson(),
      'is_seller': isSeller,
      'is_buyer': isBuyer,
      'name': name,
      'commission': commission,
      'amount': amount,
      'currency': currency,
      'transaction_type': transactionType,
      'date_create': dateCreate.toIso8601String(),
      'date_update': dateUpdate.toIso8601String(),
      'payment_date': paymentDate?.toIso8601String(),
      'is_monthly_payment': isMonthlyPayment,
      'when_monthly_payment_is_over':
          whenMonthlyPaymentIsOver?.toIso8601String(),
      'note': note,
      'transaction_name': transactionName,
      'invoice_number': invoiceNumber,
      'invoice_data': invoiceData,
      'send_invoice_email': sendInvoiceEmail,
      'documents': documents,
      'tags': tags,
      'payment_methods': paymentMethods,
      'status': status,
      'is_payed': isPayed,
      'country': country,
      'city': city,
      'street': street,
      'postal_code': postalCode,
      'tax_amount': taxAmount,
      'draft': draft,
      'created_by': createdBy,
    };
  }
}
