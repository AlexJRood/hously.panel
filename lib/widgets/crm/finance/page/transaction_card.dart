import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/transaction/transaction_expenses_model.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';

class TransactionCardRevenue extends StatelessWidget {
  final AgentTransactionModel transaction;
  final String? activeSection;
  const TransactionCardRevenue(
      {super.key, required this.transaction, this.activeSection});

  @override
  Widget build(BuildContext context) {
    final bool shouldDisplayUserBar = activeSection == null;
    final bool is_seller = transaction.isSeller;
    // final bool is_buyer = transaction.is_buyer;
    final double cardWidth = shouldDisplayUserBar ? 300 : 200;

    return Container(
      width: cardWidth,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: CrmGradients.crmGradientRight,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: shouldDisplayUserBar
                  ? BackgroundGradients.adGradient
                  : is_seller
                      ? CrmGradients.crmGradientRight
                      : CrmGradients.whiteGradient,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // gradient: CrmGradients.crmGradientRight,
                color: AppColors.light5,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (shouldDisplayUserBar) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          // gradient: CrmGradients.crmGradientRight,
                          color: AppColors.light15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    transaction.client.avatar!,
                                  ), // Obsługa domyślnego awatara
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(transaction.client.name,
                                style: AppTextStyles.interRegular16),
                            const SizedBox(width: 5),
                            Text(transaction.client.lastName.toString(),
                                style: AppTextStyles.interRegular16),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(transaction.amount.toString(),
                            style: AppTextStyles.interMedium16),
                        const SizedBox(width: 6),
                        Text(transaction.currency,
                            style: AppTextStyles.interMedium16),
                      ],
                    ),
                    Text(transaction.name.toString(),
                        style: AppTextStyles.interMedium16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionCardExpenses extends StatelessWidget {
  final TransactionExpensesModel transaction;
  const TransactionCardExpenses({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: CrmGradients.crmGradientRight,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: BackgroundGradients.adGradient,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: NetworkImage(
                              transaction.contractorAvatar,
                            ), // Obsługa domyślnego awatara
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(transaction.contractorName,
                          style: AppTextStyles.interRegular16),
                      const SizedBox(width: 5),
                      Text(transaction.contractorLastName.toString(),
                          style: AppTextStyles.interRegular16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(transaction.amount.toString(),
                      style: AppTextStyles.interMedium16dark),
                  const SizedBox(width: 6),
                  Text(transaction.currency,
                      style: AppTextStyles.interMedium16dark),
                ],
              ),
              Text(transaction.title.toString(),
                  style: AppTextStyles.interMedium16dark),
            ],
          ),
        ),
      ),
    );
  }
}
