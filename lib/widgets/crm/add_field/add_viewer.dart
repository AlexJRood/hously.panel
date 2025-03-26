import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/models/crm/crm_revenue_upload_model.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/dio_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/crm/add_field/add_field.dart';

class AddViewerForm extends ConsumerStatefulWidget {
  final List<FocusNode> focusNodes;
  const AddViewerForm({super.key, required this.focusNodes});

  @override
  AddViewerFormState createState() => AddViewerFormState();
}

class AddViewerFormState extends ConsumerState<AddViewerForm> {
  final _amountController = TextEditingController();
  final _transactionNameController = TextEditingController();
  final _invoiceNumberController = TextEditingController();
  final _invoiceDataController = TextEditingController();
  final _documentsController = TextEditingController();
  final _tagsController = TextEditingController();
  final _paymentMethodsController = TextEditingController();
  final _statusController = TextEditingController();
  final _addressController = TextEditingController();
  final _taxAmountController = TextEditingController();

  String? selectedClient;
  final _sendInvoiceEmail = false;

  @override
  void dispose() {
    // Dispose of all the controllers when the form is destroyed
    _amountController.dispose();
    _transactionNameController.dispose();
    _invoiceNumberController.dispose();
    _invoiceDataController.dispose();
    _documentsController.dispose();
    _tagsController.dispose();
    _paymentMethodsController.dispose();
    _statusController.dispose();
    _addressController.dispose();
    _taxAmountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double screenSpace = screenHeight * 0.9;
    final ScrollController _scrollController = ScrollController();
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        KeyBoardShortcuts().handleKeyEvent(event, _scrollController, 50, 100);
        
      },
      child: Container(
        height: screenSpace,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient:  CustomBackgroundGradients.appBarGradientcustom(context, ref),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Form(
            // key: _formKeyViewer, // Unique GlobalKey for form state management
            child: Column(
              children: [
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[0],
                  reqNode: widget.focusNodes[1],
                  label: 'Amount',
                  badRequestLabel: 'Please enter an amount',
                  controllerName: _amountController,
                ),
                const SizedBox(height: 10),
                Consumer(
                  builder: (context, ref, _) {
                    return FutureBuilder<List<UserContactModel>>(
                      future:
                          ref.read(clientProvider.notifier).fetchClientsList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No clients available');
                        } else {
                          final clients = snapshot.data!;
                          return DropdownButtonFormField<String>(
                            value: selectedClient,
                            focusColor: AppColors.superbee,
                            style: AppTextStyles.interMedium14_50,
                            dropdownColor: AppColors.dark50,
                            iconDisabledColor: AppColors.superbee,
                            iconEnabledColor: AppColors.superbee,
                            decoration:
                                const InputDecoration(labelText: 'Client'),
                            items: clients.map((client) {
                              return DropdownMenuItem<String>(
                                value: client.id.toString(),
                                child:
                                    Text('${client.name} ${client.lastName}'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedClient = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a client';
                              }
                              return null;
                            },
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[1],
                  reqNode: widget.focusNodes[2],
                  label: 'Transaction Name',
                  badRequestLabel: 'Please enter a transaction name',
                  controllerName: _transactionNameController,
                ),
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[2],
                  reqNode: widget.focusNodes[3],
                  label: 'Invoice Number',
                  badRequestLabel: 'Please enter an invoice number',
                  controllerName: _invoiceNumberController,
                ),
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[3],
                  reqNode: widget.focusNodes[4],
                  label: 'Invoice Data',
                  badRequestLabel: 'Please enter invoice data',
                  controllerName: _invoiceDataController,
                ),
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[4],
                  reqNode: widget.focusNodes[5],
                  label: 'Documents',
                  badRequestLabel: 'Please enter documents',
                  controllerName: _documentsController,
                ),
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[5],
                  reqNode: widget.focusNodes[6],
                  label: 'Tags',
                  badRequestLabel: 'Please enter tags',
                  controllerName: _tagsController,
                ),
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[6],
                  reqNode: widget.focusNodes[7],
                  label: 'Payment Methods',
                  badRequestLabel: 'Please enter payment methods',
                  controllerName: _paymentMethodsController,
                ),
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[7],
                  reqNode: widget.focusNodes[8],
                  label: 'Status',
                  badRequestLabel: 'Please enter a status',
                  controllerName: _statusController,
                ),
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[8],
                  reqNode: widget.focusNodes[9],
                  label: 'Address',
                  badRequestLabel: 'Please enter an address',
                  controllerName: _addressController,
                ),
                const SizedBox(height: 10),
                Textlebelfield(
                  focusNode: widget.focusNodes[9],
                  reqNode: widget.focusNodes[10],
                  label: 'Tax Amount',
                  badRequestLabel: 'Please enter a tax amount',
                  controllerName: _taxAmountController,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, _) {
                    return ElevatedButton(
                      onPressed: () {
                        // if (_formKeyViewer.currentState!.validate()) {
                        final revenueListProvider =
                            ref.read(crmRevenueProvider.notifier);
                        final revenue = CrmRevenueUploadModel(
                          amount: _amountController.text,
                          dateCreate: DateTime.now(),
                          dateUpdate: DateTime.now(),
                          client: int.parse(
                              selectedClient!), // Use selected client ID
                          transactionName: _transactionNameController.text,
                          invoiceNumber: _invoiceNumberController.text,
                          invoiceData: _parseJson(_invoiceDataController.text),
                          sendInvoiceEmail: _sendInvoiceEmail,
                          documents: _parseJsonList(_documentsController.text),
                          tags: _parseJsonList(_tagsController.text),
                          paymentMethods:
                              _parseJsonList(_paymentMethodsController.text),
                          status: _statusController.text,
                          address: _parseJson(_addressController.text),
                          taxAmount: double.parse(_taxAmountController.text),
                        );
                        revenueListProvider.addRevenue(revenue);
                        ref.read(navigationService).beamPop();
                        // }
                      },
                      child: const Text('Add Revenue'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to parse JSON
  Map<String, dynamic>? _parseJson(String jsonString) {
    if (jsonString.isEmpty) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Helper method to parse JSON list
  List<dynamic>? _parseJsonList(String jsonString) {
    if (jsonString.isEmpty) return null;
    try {
      return jsonDecode(jsonString) as List<dynamic>;
    } catch (e) {
      return null;
    }
  }
}
