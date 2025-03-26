import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/add_client_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/add_client_form_custom_drop_down.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/user_contact_custom_text_field.dart';

class TransactionCardWidget extends ConsumerWidget {
  final bool isMobile;

  const TransactionCardWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addClientForm = ref.watch(addClientFormProvider);
    final addClientFormNotifier = ref.read(addClientFormProvider.notifier);

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
                      Row(
                        children: [
                          const Expanded(
                            child: AddClientFormCustomDropDown(
                              options: ['option 1', 'option 2', 'option 3'],
                              hintText: 'Transaction type',
                              id: 5,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: AddClientFormCustomDropDown(
                              options: ['option 1', 'option 2', 'option 3'],
                              hintText: 'Status',
                              id: 6,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: AddClientFormCustomDropDown(
                              options: ['option 1', 'option 2', 'option 3'],
                              hintText: 'Payment Method',
                              id: 7,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Expanded(
                            child: AddClientFormCustomDropDown(
                              options: ['option 1', 'option 2', 'option 3'],
                              hintText: 'Currency',
                              id: 8,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: UserContactCustomTextField(
                              id: 27,
                              hintText: 'Amount',
                              controller: addClientForm.transactionAmountController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Amount cannot be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                addClientFormNotifier.updateTextField(
                                  addClientForm.transactionAmountController,
                                  value,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: UserContactCustomTextField(
                              id: 28,
                              hintText: 'Commission',
                              controller: addClientForm.transactionCommissionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Commission cannot be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                addClientFormNotifier.updateTextField(
                                  addClientForm.transactionCommissionController,
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
                      const AddClientFormCustomDropDown(
                        options: ['option 1', 'option 2', 'option 3'],
                        hintText: 'Transaction type',
                        id: 5,
                      ),
                      const SizedBox(height: 12),
                      const AddClientFormCustomDropDown(
                        options: ['option 1', 'option 2', 'option 3'],
                        hintText: 'Status',
                        id: 6,
                      ),
                      const SizedBox(height: 12),
                      const AddClientFormCustomDropDown(
                        options: ['option 1', 'option 2', 'option 3'],
                        hintText: 'Payment Method',
                        id: 7,
                      ),
                      const SizedBox(height: 12),
                      const AddClientFormCustomDropDown(
                        options: ['option 1', 'option 2', 'option 3'],
                        hintText: 'Currency',
                        id: 8,
                      ),
                      const SizedBox(height: 12),
                      UserContactCustomTextField(
                        id: 27,
                        hintText: 'Amount',
                        controller: addClientForm.transactionAmountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Amount cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          addClientFormNotifier.updateTextField(
                            addClientForm.transactionAmountController,
                            value,
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      UserContactCustomTextField(
                        id: 28,
                        hintText: 'Commission',
                        controller: addClientForm.transactionCommissionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Commission cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          addClientFormNotifier.updateTextField(
                            addClientForm.transactionCommissionController,
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
