import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/dio_provider.dart';
import 'package:hously_flutter/utils/pie_menu/revenue_crm.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/const/url.dart';

const configUrl = URLs.baseUrl;
const defaultAvatarUrl = '$configUrl/media/avatars/avatar.jpg';



class CrmExpensesList extends ConsumerWidget {
  const CrmExpensesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crmExpensesProviderAsyncValue = ref.watch(crmRevenueProvider);
    double screenWidth = MediaQuery.of(context).size.width;

    return crmExpensesProviderAsyncValue.when(
      data: (expensesCrm) {
        if (expensesCrm.isEmpty) {
          return Center(
              child: Text('Brak przychodów', style: AppTextStyles.interRegular16));

        }
        return ListView.builder(
          itemCount: expensesCrm.length,
          itemBuilder: (context, index) {
            final expenses = expensesCrm[index];
            return PieMenu(
              onPressedWithDevice: (kind) {
                if (kind == PointerDeviceKind.mouse ||
                    kind == PointerDeviceKind.touch) {
                  Navigator.pushNamed(
                    context,
                    '/pro/finance/expenses/${expenses.id}',
                  );
                }
              },
              actions: pieMenuCrmRevenues(ref, expenses.id, expenses, context),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: screenWidth / 5 * 3,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: BackgroundGradients.adGradient,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    defaultAvatarUrl), // Obsługa domyślnego awatara
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${expenses.name}',
                                          style: AppTextStyles.interMedium18),
                                      const SizedBox(height: 5),
                                      Text('${expenses.note}',
                                          style: AppTextStyles.interMedium),
                                    ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(expenses.amount, style: AppTextStyles.interMedium18),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) {
        return Center(
            child: Text('Error: $err', style: AppTextStyles.interMedium));
      },
    );
  }
}
