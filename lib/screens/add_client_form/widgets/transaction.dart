import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/controllers/transaction_controlers.dart';
import 'package:hously_flutter/screens/add_client_form/provider/send_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/components/transaction/transaction_custom_drop_down.dart';
import 'package:hously_flutter/screens/add_client_form/components/usercontact/user_contact_custom_text_field.dart';
import 'package:hously_flutter/screens/add_client_form/provider/transaction_provider.dart';

class TransactionCardWidget extends ConsumerWidget {
  final bool isMobile;

  const TransactionCardWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addClientForm = ref.watch(addClientFormProvider);
    final agentTransactionProvider = ref.read(agentTransactionCacheProvider.notifier);
    final transactionControllers = ref.watch(transactionControllersProvider);

    return Column(
      children: [
        Container(
          height: 48,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(35, 35, 35, 1),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(6),
              topLeft: Radius.circular(6),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TRANSACTIONS',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                Icon(
                  Icons.expand_more,
                  color: Color.fromRGBO(255, 255, 255, 1),
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(50, 50, 50, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (!isMobile)
                  Column(
                    children: [
                      Row(children: [
                        Expanded(
                        child: UserContactCustomTextField(
                          id: 99,
                          valueKey: 'title',
                          hintText: 'Title',
                          controller: transactionControllers.nameController, // Sprawdź, czy to TextEditingController
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Title cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (valueKey, value) {
                            agentTransactionProvider.addTransactionData(
                              valueKey,
                              value,
                            );
                          },
                        ),
                      ),
                      ],
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Expanded(
                            child: AgentTransactionFormCustomDropDown(
                              options: ['Cash', 'Transfer', 'Card'],
                              hintText: 'Payment Method',
                              valueKey: 'payment_methods',
                              id: 7,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Expanded(
                            child: AgentTransactionFormCustomDropDown(
                              options: ['PLN', 'EUR', 'USD'],
                              hintText: 'Currency',
                              valueKey: 'currency',
                              id: 8,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: UserContactCustomTextField(
                              id: 27,
                              valueKey: 'amount',
                              hintText: 'Amount',
                              controller: transactionControllers.amountController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Amount cannot be empty";
                                }
                                return null;
                              },
                              onChanged: (valueKey, value) {
                                agentTransactionProvider.addTransactionData(
                                  valueKey,
                                  value,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: UserContactCustomTextField(
                              id: 28,
                              valueKey: 'commission',
                              hintText: 'Commission',
                              controller: transactionControllers.commissionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Commission cannot be empty";
                                }
                                return null;
                              },
                              onChanged: (valueKey, value) {
                                agentTransactionProvider.addTransactionData(
                                  valueKey,
                                  value,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                if (isMobile)
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      const AgentTransactionFormCustomDropDown(
                        options: ['Cash', 'Transfer', 'Card'],
                        hintText: 'Payment Method',
                        valueKey: 'payment_methods',
                        id: 7,
                      ),
                      const SizedBox(height: 12),
                      const AgentTransactionFormCustomDropDown(
                        options: ['PLN', 'EUR', 'USD'],
                        hintText: 'Currency',
                        valueKey: 'currency',
                        id: 8,
                      ),
                      const SizedBox(height: 12),
                      UserContactCustomTextField(
                        id: 27,
                        valueKey: 'amount',
                        hintText: 'Amount',
                        controller: transactionControllers.amountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Amount cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (valueKey, value) {
                          agentTransactionProvider.addTransactionData(
                            valueKey,
                            value,
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      UserContactCustomTextField(
                        id: 28,
                        valueKey: 'commission',
                        hintText: 'Commission',
                        controller: transactionControllers.commissionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Commission cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (valueKey, value) {
                          agentTransactionProvider.addTransactionData(
                            valueKey,
                            value,
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
