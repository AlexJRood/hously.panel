import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/models/crm/crm_revenue_upload_model.dart';
import 'package:hously_flutter/state_managers/data/crm/add_field/dio_provider.dart';
import 'package:hously_flutter/state_managers/data/crm/add_field/sell_offer_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/crm/add_field/add_sell.dart';
import 'package:hously_flutter/widgets/crm/add_field/add_transaction.dart';
import 'package:hously_flutter/widgets/crm/add_field/add_viewer.dart';

import '../../../platforms/html_utils_stub.dart'
if (dart.library.html) '../../../platforms/html_utils_web.dart';

class CrmAddPopPc extends ConsumerStatefulWidget {
  final String? initialForm;

  const CrmAddPopPc({super.key, required this.initialForm});

  @override
  CrmAddPopPcState createState() => CrmAddPopPcState();
}

class CrmAddPopPcState extends ConsumerState<CrmAddPopPc> {
  String currentForm = 'AddSellForm';
  final _noteController = TextEditingController();

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _clientTypeController = TextEditingController();

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
  List<FocusNode> sellFocusNodes = List.generate(11, (index) => FocusNode());
  List<FocusNode> transFocusNodes = List.generate(11, (index) => FocusNode());
  List<FocusNode> addVieFocusNodes = List.generate(11, (index) => FocusNode());

  @override
  void dispose() {
    _noteController.dispose();

    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _clientTypeController.dispose();

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
    for (var focusNode in sellFocusNodes) {
      focusNode.dispose();
    }
    for (var focusNode in transFocusNodes) {
      focusNode.dispose();
    }
    for (var focusNode in addVieFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentForm = widget.initialForm ?? 'AddSellForm';
    sellFocusNodes = List.generate(11, (_) => FocusNode());
    transFocusNodes = List.generate(11, (_) => FocusNode());
    addVieFocusNodes = List.generate(11, (_) => FocusNode());
    print('Initial Form: $currentForm');
  }

  void _setCurrentForm(String formName) {
    setState(() {
      currentForm = formName;
      print('Current Form: $currentForm');
    });

    // Zmieniamy URL bez przejścia do nowej strony
updateUrl('/pro/finance/revenue/add/$formName');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenSpace = screenHeight * 0.9;

    Widget formWidget;
    switch (currentForm) {
      case 'AddSellForm':
        formWidget = AddSellForm(
          focusNodes: sellFocusNodes,
        );
        break;
      case 'AddTransactionForm':
        formWidget = AddTransactionForm(
          focusNodes: transFocusNodes,
        );
        break;
      case 'AddViewerForm':
        formWidget = AddViewerForm(
          focusNodes: addVieFocusNodes,
        );
        break;
      default:
        formWidget = const Text('Nieprawidłowy formularz');
        break;
    }

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        // Check if the pressed key matches the stored pop key

        if (event.logicalKey == ref.read(popKeyProvider) &&
            event is KeyDownEvent) {
          ref.read(navigationService).beamPop();
        }
      },
      child: Stack(
        children: [
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.8),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          GestureDetector(onTap: () {
            ref.read(navigationService).beamPop();
          }),
          Hero(
            tag: 'addPagePop-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag 
            child: Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: screenSpace,
                      child: Column(
                        children: [
                          // Oglądający Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: currentForm == 'AddViewerForm'
                                  ? BackgroundGradients.oppacityGradient75
                                  : BackgroundGradients.appBarGradient,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ElevatedButton(
                              style: buttonAddForm,
                              onPressed: () {
                                _setCurrentForm('AddViewerForm');
                              },
                              child: Text('Oglądający'.tr,
                                  style: AppTextStyles.interRegular14),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Sprzedaż Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: currentForm == 'AddSellForm'
                                  ? BackgroundGradients.oppacityGradient75
                                  : BackgroundGradients.appBarGradient,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ElevatedButton(
                              style: buttonAddForm,
                              onPressed: () {
                                _setCurrentForm('AddSellForm');
                              },
                              child: Text('Sprzedaż'.tr,
                                  style: AppTextStyles.interRegular14),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Poszukiwanie Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: currentForm == 'AddTransactionForm'
                                  ? BackgroundGradients.oppacityGradient75
                                  : BackgroundGradients.appBarGradient,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ElevatedButton(
                              style: buttonAddForm,
                              onPressed: () {
                                _setCurrentForm('AddTransactionForm');
                              },
                              child: Text('Poszukiwanie'.tr,
                                  style: AppTextStyles.interRegular14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    flex: 20,
                    child: formWidget, // Renderowanie odpowiedniego formularza
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenSpace - 80,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: BackgroundGradients.appBarGradient,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            child: TextNotelebelfield(
                              label: 'Note',
                              badRequestLabel: 'Please enter a note',
                              controllerName: _noteController,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: const BoxDecoration(
                            gradient: BackgroundGradients
                                .appBarGradient, // Twój gradient
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: ElevatedButton(
                            style: elevatedButtonStyleAddCrm,
                            onPressed: () async {
                              final client = UserContactModel(
                                id: 0,
                                name: _nameController.text,
                                lastName: _lastNameController.text,
                                email: _emailController.text,
                                phoneNumber: _phoneNumberController.text,
                                //clientType: _clientTypeController.text, //change to production
                              );
      
                                final transaction = CrmRevenueUploadModel(
                                  sendInvoiceEmail: null,
                                  dateCreate: DateTime.now(),
                                  dateUpdate: DateTime.now(),
                                  amount: _amountController.text,
                                  transactionName:
                                      _transactionNameController.text,
                                  invoiceNumber: _invoiceNumberController.text,
                                  invoiceData:
                                      _parseJson(_invoiceDataController.text),
                                  documents:
                                      _parseJsonList(_documentsController.text),
                                  tags: _parseJsonList(_tagsController.text),
                                  paymentMethods: _parseJsonList(
                                      _paymentMethodsController.text),
                                  status: _statusController.text,
                                  address: _parseJson(_addressController.text),
                                  taxAmount:
                                      double.parse(_taxAmountController.text),
                                );
      
                                // Załaduj stan oferty
                                final offerState = ref
                                    .read(crmAddSellOfferProvider.notifier)
                                    .state;
      
                                // Wywołaj providera do wysyłania danych
                                await ref
                                    .read(crmClientTransactionOfferProvider
                                        .notifier)
                                    .addClientTransactionOffer(
                                      client: client,
                                      transaction: transaction,
                                      offer: offerState,
                                    );
                                print(client);
                                print(transaction);
                                print(offerState);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
                                child: Text(
                                  'Dodaj'.tr,
                                  style: const TextStyle(
                                      color: AppColors
                                          .light), // Dopasuj kolor tekstu do gradientu
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
    
  }

  Map<String, dynamic>? _parseJson(String jsonString) {
    if (jsonString.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  List<dynamic>? _parseJsonList(String jsonString) {
    if (jsonString.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(jsonString) as List<dynamic>;
    } catch (e) {
      return null;
    }
  }
}

class Textlebelfield extends StatefulWidget {
  final FocusNode focusNode;
  final FocusNode reqNode;
  final TextEditingController controllerName;
  final String label;
  final String badRequestLabel;

  const Textlebelfield({
    Key? key,
    required this.focusNode,
    required this.reqNode,
    required this.label,
    required this.badRequestLabel,
    required this.controllerName,
  }) : super(key: key);

  @override
  _TextlebelfieldState createState() => _TextlebelfieldState();
}

class _TextlebelfieldState extends State<Textlebelfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(widget.reqNode);
      },
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.badRequestLabel;
        }
        return null;
      },
    );
  }
}

class TextNotelebelfield extends StatefulWidget {
  final TextEditingController controllerName;
  final String label;
  final String badRequestLabel;

  const TextNotelebelfield({
    Key? key,
    required this.label,
    required this.badRequestLabel,
    required this.controllerName,
  }) : super(key: key);

  @override
  _TextNotelebelfieldState createState() => _TextNotelebelfieldState();
}

class _TextNotelebelfieldState extends State<TextNotelebelfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: true,
      minLines: null,
      maxLines: null,
      controller: widget.controllerName,
      style: AppTextStyles.interMedium16,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppTextStyles.interMedium14_50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.badRequestLabel;
        }
        return null;
      },
    );
  }
}
