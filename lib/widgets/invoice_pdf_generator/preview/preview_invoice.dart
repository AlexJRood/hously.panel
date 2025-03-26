import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/components/buttontile.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/components/customdatepicker.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/components/customdropdown.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/components/headingtile.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/components/terms.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/components/tiles.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/const.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/model/invoise_model.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/preview/pdf_invoice.dart';
import 'package:intl/intl.dart';

class FloatingInvoicePage extends ConsumerStatefulWidget {
  const FloatingInvoicePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FloatingInvoicePageState createState() => _FloatingInvoicePageState();
}

class _FloatingInvoicePageState extends ConsumerState<FloatingInvoicePage> {
  bool showInvoiceForm = false;
  String? tdy;
  String? tmr;
  TextEditingController asiigneeontroller = TextEditingController();
  TextEditingController terms = TextEditingController();
  TextEditingController ordercontroller = TextEditingController();
  List<Widget> customrows = [];
  DateTime? selectedIssueDate;
  DateTime? selectedDueDate;
  String? companyname;
  String? address;
  String? vatnumber;
  double totalAmount = 0.0;
  @override
  void initState() {
    super.initState();

    customrows.add(_buildRow(0));
    tdy = DateFormat('MM.dd.yyyy').format(DateTime.now());
    tmr = DateFormat('MM.dd.yyyy')
        .format(DateTime.now().add(const Duration(days: 1)));
    terms.text =
        'If unpaid by net-7, a late fee of 20% on the invoice amount will be applicable (days will be counted based on the invoice date).';
  }

  void _addAnotherLine() {
    setState(() {
      customrows.add(_buildRow(customrows.length));
    });
  }

  void updateTotal(double newTotal) {
    setState(() {
      totalAmount = newTotal;
    });
  }

  Widget _buildRow(int index) {
    return RowCreator(
      onTotalUpdate: updateTotal,
      index: index,
      onDelete: () {
        _deleteRow(index);
      },
    ).buildRow();
  }

  void _deleteRow(int index) {
    setState(() {
      if (customrows.length == 1) {
      } else {
        customrows.removeAt(index);
      }
    });
  }

  void _handleDateChange(DateTime? issueDate, DateTime? dueDate) {
    setState(() {
      selectedIssueDate = issueDate;
      selectedDueDate = dueDate;
    });
  }

  double calculateTotalPrice() {
    double total = 0.0;

    for (var item in selecteditems) {
      double netAmount = item.netUnitPrice * item.quantity;

      double vatAmount = netAmount * (item.vatRate / 100);

      total += netAmount + vatAmount;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isSmallScreen = screenWidth < 800;
    final toggle = ref.watch(invoicetoggleProvider);
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          toggleBoolean(ref);
        },
        child: Stack(
          children: [
            if (true) ...[
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2.0),
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              Center(
                child: GestureDetector(onTap: (){
                  
                },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: isSmallScreen ? 500 : screenWidth * 0.6,
                    height: screenHeight * 0.8,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Fixed "Create Invoice" Title
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Create Invoice',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 24 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Scrollable content
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  const Row(
                                    children: [
                                      Headingtile(width: 100, text: "Assignee"),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Headingtile(width: 100, text: "Customer")
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          cursorColor: Colors.black,
                                          decoration: customdecoration()
                                              .customInputDecoration(
                                            "Fill this field",
                                          ),
                                          controller: asiigneeontroller,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: BuyerSearchField(
                                          buyersList: buyerslist,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Row(
                                    children: [
                                      Headingtile(
                                          width: 100, text: "Issuie Date"),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Headingtile(width: 100, text: "Due Date")
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  DateSelectionRow(
                                    todaydate: tdy!,
                                    tomorowsdate: tmr!,
                                    onDatesChanged: _handleDateChange,
                                  ),
                                  const SizedBox(height: 10),
                                  const Row(
                                    children: [
                                      Headingtile(
                                          width: 150, text: "Order Number"),
                                      Spacer(
                                        flex: 2,
                                      ),
                                      Headingtile(width: 100, text: "Projects")
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: ordercontroller,
                                          cursorColor: Colors.black,
                                          decoration: customdecoration()
                                              .customInputDecoration(
                                            "Order Number",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormField(
                                          cursorColor: Colors.black,
                                          decoration: customdecoration()
                                              .customInputDecoration("project"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Items',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ...customrows,
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: _addAnotherLine,
                                      child: const Text('Add Another Line'),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Headingtile(
                                          width: 150,
                                          text: "Terms & Conditions")),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Terms(terms: terms)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Buttontile(
                                  buttontext: "Save",
                                  onPressed: () async {
                                    if (selectedIssueDate == null ||
                                        selectedDueDate == null ||
                                        asiigneeontroller.text.isEmpty ||
                                        currentbuyer.isEmpty ||
                                        selecteditems.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Please fill in all fields and select items before generating the invoice.',
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else {
                                      try {
                                        final Uint8List logoBytes =
                                            await rootBundle
                                                .load('assets/images/image.png')
                                                .then((data) =>
                                                    data.buffer.asUint8List());

                                        generateInvoicePdf(
                                            invoice,
                                            logoBytes,
                                            selectedIssueDate!,
                                            selectedDueDate!,
                                            terms.text);

                                        setState(() {
                                          showInvoiceForm = false;
                                          customrows.clear();
                                          selecteditems.clear();
                                          customrows.add(_buildRow(0));
                                        });
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Failed to generate PDF: $e'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  buttoncolor: Colors.blue,
                                ),
                                const SizedBox(width: 10),
                                Buttontile(
                                  onPressed: () {
                                    setState(() {
                                      showInvoiceForm = false;
                                      customrows.clear();
                                      selecteditems.clear();
                                      customrows.add(_buildRow(0));
                                      totalAmount = 0;
                                    });
                                  },
                                  buttoncolor: Colors.grey,
                                  buttontext: "Cancel",
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Total: ${totalAmount.toString()}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
