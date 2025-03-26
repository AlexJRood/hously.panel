import 'package:hously_flutter/widgets/invoice_pdf_generator/model/invoise_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


import 'package:printing/printing.dart'; // For printing and sharing the PDF

import 'dart:typed_data';

import 'package:int_to_words/int_to_words.dart';

void generateInvoicePdf(Invoice invoice, Uint8List logoBytes, DateTime issuie,
    DateTime due, String termsandconditions) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  height: 80,
                  width: 80,
                  child: pw.Image(
                    pw.MemoryImage(logoBytes),
                  ),
                ),
                // Invoice Info
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      "Faktura nr ${invoice.invoiceNumber}",
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                        style: const pw.TextStyle(
                          fontSize: 10,
                        ),
                        "Data wystawienia: ${issuie.toLocal()}"),
                    pw.Text(
                      "Data sprzedazy: ${due.toLocal()}",
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    pw.Text(
                      "Termin platnosci: ${invoice.paymentDetails.dueDate.toLocal()}",
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    pw.Text(
                      "Metoda platnosci: ${invoice.paymentDetails.paymentMethod}",
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 10),

            // Seller and Buyer Information
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _buildSellerSection(invoice.sellerdummy),
                _buildBuyerSection(invoice.buyer),
              ],
            ),
            pw.SizedBox(height: 80),

            // Itemized Table
            _buildItemizedTable(invoice.items),
            pw.SizedBox(height: 15),

            // VAT Summary and Total
            _buildVatSummaryAndTotal(invoice),

            // Notes and Signature
            pw.SizedBox(height: 20),
            pw.Text("Terms and Conditions",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
            pw.SizedBox(height: 10),
            pw.Text(termsandconditions,
                style: pw.TextStyle(color: const PdfColor(0, 0, 1))),
            pw.SizedBox(height: 80),

            // Footer Signature
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Janusz Nowak \n",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Imie i nazwisko osoby uprawnionej",
                    style: const pw.TextStyle(fontSize: 8)),
                pw.Text("do wystawienia faktury"),
              ],
            ),
          ],
        );
      },
    ),
  );

  // Save or share the PDF
  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: 'invoice_${invoice.invoiceNumber}.pdf',
  );
}

// Helper function to build Seller Section
pw.Widget _buildSellerSection(Sellerdummy seller) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text("Sprzedawca:",
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
      pw.Text(seller.companyName),
      pw.Text(seller.address),
      pw.Text("NIP: ${seller.vatNumber}",
          style: const pw.TextStyle(
            fontSize: 10,
          )),
    ],
  );
}

// Helper function to build Buyer Section
pw.Widget _buildBuyerSection(Buyer buyer) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text("Nabywca:",
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
      pw.Text(
        buyer.companyName,
        style: const pw.TextStyle(
          fontSize: 10,
        ),
      ),
      pw.Text(buyer.address),
      pw.Text("NIP: ${buyer.vatNumber}",
          style: const pw.TextStyle(
            fontSize: 10,
          )),
    ],
  );
}

// Helper function to build Itemized Table
pw.Widget _buildItemizedTable(List<InvoiceItem> items) {
  return pw.TableHelper.fromTextArray(
    cellHeight: 10,
    headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
    cellStyle: const pw.TextStyle(
      fontSize: 8,
    ),
    headers: [
      'Lp',
      'Nazwa',
      'Jedn',
      'Ilosc',
      'Cena netto',
      'Stawka',
      'Wartosc netto',
      'Wartosc brutto'
    ],
    columnWidths: {
      0: const pw.FixedColumnWidth(25.0), // Column 1 width
      1: const pw.FixedColumnWidth(100.0), // Column 2 width
      2: const pw.FixedColumnWidth(40.0), // Column 3 width
      3: const pw.FixedColumnWidth(60.0), // Column 4 width
      4: const pw.FixedColumnWidth(60.0), // Column 5 width
      5: const pw.FixedColumnWidth(40.0), // Column 6 width
      6: const pw.FixedColumnWidth(60.0), // Column 7 width
      7: const pw.FixedColumnWidth(60.0), // Column 8 width
    },
    data: items.asMap().entries.map((entry) {
      final item = entry.value;
      final index = entry.key + 1;
      return [
        '$index',
        item.description,
        'szt.',
        '${item.quantity}',
        '${item.netUnitPrice.toStringAsFixed(2)} PLN',
        '${item.vatRate}%',
        '${item.netAmount.toStringAsFixed(2)} PLN',
        '${item.grossAmount.toStringAsFixed(2)} PLN',
      ];
    }).toList(),
  );
}

// Helper function to build VAT summary and total
pw.Widget _buildVatSummaryAndTotal(Invoice invoice) {
  final vatRate = invoice.items.isNotEmpty ? invoice.items.first.vatRate : 0;
  final netTotal =
      invoice.items.fold(0.0, (double sum, item) => sum + item.netAmount);
  final vatAmount =
      invoice.items.fold(0.0, (double sum, item) => sum + item.vatAmount);
  final grossTotal =
      invoice.items.fold(0.0, (double sum, item) => sum + item.grossAmount);

  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    crossAxisAlignment:
        pw.CrossAxisAlignment.start, // Aligns columns at the top
    children: [
      pw.TableHelper.fromTextArray(
        cellHeight: 6,
        headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
        cellStyle: const pw.TextStyle(fontSize: 8),
        columnWidths: {
          0: const pw.FixedColumnWidth(58.125),
          1: const pw.FixedColumnWidth(58.125),
          2: const pw.FixedColumnWidth(58.125),
          3: const pw.FixedColumnWidth(58.125),
        },
        headers: ['Stawka VAT', 'Wartosc netto', 'Kwota VAT', 'Wartosc brutto'],
        data: [
          [
            '${vatRate}%',
            '${netTotal.toStringAsFixed(2)} PLN',
            '${vatAmount.toStringAsFixed(2)} PLN',
            '${grossTotal.toStringAsFixed(2)} PLN',
          ],
        ],
      ),
      pw.SizedBox(width: 25),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start, // Align to the start
        children: [
          pw.SizedBox(height: 4),
          pw.Text(
            "zaplacamo:",
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            "Razem:",
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
        ],
      ),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end, // Align to the start
        children: [
          pw.SizedBox(height: 4),
          pw.Text(
            invoice.paidamount
                .toString(), // Adjust this to be dynamic if necessary
            style: const pw.TextStyle(fontSize: 8),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            "${grossTotal.toStringAsFixed(2)} PLN",
            style: const pw.TextStyle(fontSize: 8),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            "Slownie ",
            style: pw.TextStyle(fontSize: 8),
          ),
          pw.Text(
            numberToWords(grossTotal.toInt()),
            style: pw.TextStyle(fontSize: 8),
          ),
        ],
      ),
    ],
  );
}

// Function to convert amount to words (Polish format)
String numberToWords(int number) {
  final IntToWords _number = IntToWords();
  final words = _number.convert(number);
  return words;
}
