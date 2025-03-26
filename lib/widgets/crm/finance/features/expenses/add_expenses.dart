import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/expenses_model_new.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/api_servises_expenses.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';

class CrmAddExpensesPopPc extends ConsumerStatefulWidget {
  const CrmAddExpensesPopPc({super.key});

  @override
  CrmAddExpensesPopPcState createState() => CrmAddExpensesPopPcState();
}

class CrmAddExpensesPopPcState extends ConsumerState<CrmAddExpensesPopPc> {
  final _formKeyAddExpenses = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  late TextEditingController _invoiceNumberController;
  late TextEditingController _statusController;
  late TextEditingController _taxAmountController;
  int? selectedClient;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
    _invoiceNumberController = TextEditingController();
    _statusController = TextEditingController();
    _taxAmountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _invoiceNumberController.dispose();
    _statusController.dispose();
    _taxAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Ta część odpowiada za efekt rozmycia tła
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        // Obsługa dotknięcia w dowolnym miejscu aby zamknąć modal
        GestureDetector(onTap: () {          
                    Navigator.of(context).pop();
        }),
        Hero(
          tag: 'addExpensesPagePop',
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.5,
              height: screenHeight * 0.5,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.appBarGradientcustom(context, ref),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKeyAddExpenses,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Consumer(
                        builder: (context, ref, _) {
                          return FutureBuilder<List<UserContactModel>>(
                            future:
                                ref.read(clientProvider.notifier).fetchClientsList(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Text('No clients available');
                              } else {
                                final clients = snapshot.data!;
                                return DropdownButtonFormField<int>(
                                  value: selectedClient,
                                  focusColor: AppColors.superbee,
                                  style: AppTextStyles.interMedium14_50,
                                  dropdownColor: AppColors.dark50,
                                  iconDisabledColor: AppColors.superbee,
                                  iconEnabledColor: AppColors.superbee,
                                  decoration:
                                      const InputDecoration(labelText: 'Client'),
                                  items: clients.map((client) {
                                    return DropdownMenuItem<int>(
                                      value: client.id,
                                      child: Text('${client.name} ${client.lastName}'),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedClient = value;
                                    });
                                  },
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Please select a client';
                                  //   }
                                  //   return null;
                                  // },
                                );
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextLabelField(
                        label: 'Amount',
                        badRequestLabel: 'Please enter an amount',
                        controllerName: _amountController,
                      ),
                      const SizedBox(height: 10),
                      TextLabelField(
                        label: 'Note',
                        badRequestLabel: 'Please enter a note',
                        controllerName: _noteController,
                      ),
                      const SizedBox(height: 10),
                      TextLabelField(
                        label: 'Invoice Number',
                        badRequestLabel: 'Please enter an invoice number',
                        controllerName: _invoiceNumberController,
                      ),
                      const SizedBox(height: 10),
                      TextLabelField(
                        label: 'Status',
                        badRequestLabel: 'Please enter a status',
                        controllerName: _statusController,
                      ),
                      const SizedBox(height: 10),
                      TextLabelField(
                        label: 'Tax Amount',
                        badRequestLabel: 'Please enter a tax amount',
                        controllerName: _taxAmountController,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        child: const Text('Add Expense'),
                        onPressed: () {
                          if (_formKeyAddExpenses.currentState!.validate()) {
                            // Create an Expense object
                            final expense = ExpenseModelNew(
                              clientId: selectedClient,
                              amount: double.parse(_amountController.text),
                              note: _noteController.text,
                              invoiceNumber: _invoiceNumberController.text,
                              status: _statusController.text,
                              taxAmount: double.parse(_taxAmountController.text),
                              // Add other fields here if necessary
                            );

                            Navigator.of(context).pop();

                            ref.read(expensesProvider.notifier).createExpense(expense);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TextLabelField extends StatefulWidget {
  final TextEditingController controllerName;
  final String label;
  final String badRequestLabel;

  const TextLabelField({
    super.key,
    required this.label,
    required this.badRequestLabel,
    required this.controllerName,
  });

  @override
  _TextLabelFieldState createState() => _TextLabelFieldState();
}

class _TextLabelFieldState extends State<TextLabelField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controllerName,
      style: AppTextStyles.interMedium16,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppTextStyles.interMedium14_50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      selectionHeightStyle: ui.BoxHeightStyle.tight,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.badRequestLabel;
        }
        return null;
      },
    );
  }
}






// Define the Expense class (this should match the model from Django)
class Expense {
  final double amount;
  final String note;
  final String invoiceNumber;
  final String status;
  final double taxAmount;

  Expense({
    required this.amount,
    required this.note,
    required this.invoiceNumber,
    required this.status,
    required this.taxAmount,
  });

  // Add other fields and methods if necessary
}
