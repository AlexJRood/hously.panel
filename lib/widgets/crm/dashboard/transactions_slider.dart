import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/crm_expenses_download_model.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/state_managers/data/crm/components/finance_chart/provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart'; // Importowanie pakietu intl

class FinancialWidget extends ConsumerWidget {
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'pl_PL',
    symbol: '', // Symbol waluty można dodać osobno
    decimalDigits: 2,
  );

  FinancialWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(revenueAndExpensesProvider);
    ScrollController scrollController = ScrollController();
    return data.when(
      data: (data) {
        final revenues = data['revenues'] as List<AgentTransactionModel>;
        final expenses = data['expenses'] as List<CrmExpensesDownloadModel>;

        return Column(
          children: [
            // Rząd dla przychodów
            DragScrollView(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: revenues.map((revenue) {
                        final formattedAmount =
                            currencyFormat.format(double.parse(revenue.amount));
                        return PieMenu(
                          onPressedWithDevice: (kind) {
                            if (kind == PointerDeviceKind.mouse ||
                                kind == PointerDeviceKind.touch) {
                              ref.read(navigationService).pushNamedScreen(
                                    Routes.feedView,
                                  );
                            }
                          },
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.only(right: 10.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.revenueGreen,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    '$formattedAmount ${revenue.currency}',
                                    // Wyświetlanie sformatowanej kwoty
                                    style: AppTextStyles.interMedium16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: expenses.map((expense) {
                        final formattedAmount =
                            currencyFormat.format(double.parse(expense.amount));
                        return PieMenu(
                          onPressedWithDevice: (kind) {
                            if (kind == PointerDeviceKind.mouse ||
                                kind == PointerDeviceKind.touch) {
                              ref
                                  .read(navigationService)
                                  .pushNamedScreen(Routes.feedView);
                            }
                          },
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.only(right: 10.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.expensesRed,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    '- $formattedAmount ${expense.currency}',
                                    // Wyświetlanie sformatowanej kwoty
                                    style: AppTextStyles.interMedium16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      loading: () => ShimmerlistPlaceholder(),
      error: (error, stackTrace) => ShimmerlistPlaceholder(),
    );
  }
}

class ShimmerlistPlaceholder extends StatelessWidget {
  const ShimmerlistPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollcontroller = ScrollController();
    return Column(
      children: [
        DragScrollView(
          controller: scrollcontroller,
          child: SingleChildScrollView(
            controller: scrollcontroller,
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    8, // Adjust the number of shimmer items
                    (index) => Container(
                      height: 25,
                      margin: const EdgeInsets.only(right: 10.0),
                      child: const ShimmerPlaceholder(
                        radius: 5.0,
                        height: 25,
                        width: 100, // Simulate revenue item width
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(
                    8, // Adjust the number of shimmer items
                    (index) => Container(
                      height: 25,
                      margin: const EdgeInsets.only(right: 10.0),
                      child: const ShimmerPlaceholder(
                        radius: 5.0,
                        height: 25,
                        width: 100, // Simulate expense item width
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
