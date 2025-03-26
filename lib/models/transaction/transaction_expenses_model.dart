import 'package:hously_flutter/models/crm/crm_expenses_download_model.dart';

import 'package:hously_flutter/const/url.dart';

const configUrl = URLs.baseUrl;

const defaultAvatarUrl = '$configUrl/media/avatars/avatar.jpg';


class TransactionExpensesModel {
  final int id;
  final String amount;
  final String currency;
  final String? title;
  final DateTime dateCreate;
  final String contractorAvatar;
  final String contractorName;
  final String contractorLastName;

  const TransactionExpensesModel({
    required this.id,
    this.title,
    required this.amount,
    required this.currency,
    required this.dateCreate,
    required this.contractorAvatar,
    required this.contractorName,
    required this.contractorLastName,
  });

  factory TransactionExpensesModel.fromCrmExpensesDownload(
      CrmExpensesDownloadModel expenses) {
    return TransactionExpensesModel(
      id: expenses.id,
      title: expenses.name,
      amount: expenses.amount,
      currency: expenses.currency,
      dateCreate: expenses.dateCreate,
      contractorAvatar: defaultAvatarUrl, 
      contractorName: expenses.name ?? 'Unknown',
      contractorLastName: expenses.name ?? '',
    );
  }
}
