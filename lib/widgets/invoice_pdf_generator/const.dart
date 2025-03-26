import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/model/invoise_model.dart';

Sellerdummy sellerdummy = Sellerdummy(
  companyName: "ABC Pvt Ltd",
  address: "123 Market Street, Warsaw, Poland",
  vatNumber: "PL1234567890",
);

List<InvoiceItem> itemlist = [
  InvoiceItem(
    description: "Coca-Cola 1L Bottle",
    quantity: 10,
    netUnitPrice: 2.50,
    vatRate: 23.0,
  ),
  InvoiceItem(
    description: "Pepsi 330ml Can",
    quantity: 20,
    netUnitPrice: 1.50,
    vatRate: 23.0,
  ),
  InvoiceItem(
    description: "Lays Classic Chips 200g",
    quantity: 15,
    netUnitPrice: 3.00,
    vatRate: 23.0,
  ),
  InvoiceItem(
    description: "JBL Bluetooth Speaker",
    quantity: 5,
    netUnitPrice: 50.00,
    vatRate: 23.0,
  ),
  InvoiceItem(
    description: "Nestlé KitKat 4 Finger Bar",
    quantity: 30,
    netUnitPrice: 0.80,
    vatRate: 23.0,
  ),
  InvoiceItem(
    description: "Samsung Galaxy S21",
    quantity: 3,
    netUnitPrice: 700.00,
    vatRate: 23.0,
  ),
  InvoiceItem(
    description: "Apple AirPods Pro",
    quantity: 8,
    netUnitPrice: 250.00,
    vatRate: 23.0,
  ),
  InvoiceItem(
    description: "Nivea Moisturizing Cream 100ml",
    quantity: 25,
    netUnitPrice: 4.00,
    vatRate: 23.0,
  ),
  InvoiceItem(
    description: "Sony PlayStation 5",
    quantity: 2,
    netUnitPrice: 500.00,
    vatRate: 23.0,
  ),
  InvoiceItem(
    description: "Adidas Running Shoes",
    quantity: 6,
    netUnitPrice: 100.00,
    vatRate: 23.0,
  ),
];

List<Buyer> currentbuyer = [];
List<Buyer> buyerslist = [
  Buyer(
      companyName: "Pepsi",
      address: "Purchase, New York, USA",
      vatNumber: "446466"),
  Buyer(
      companyName: "Lays",
      address: "Bangalore, Karnataka, India",
      vatNumber: "5454646"),
  Buyer(
      companyName: "JBL",
      address: "Los Angeles, California, USA",
      vatNumber: "453344"),
  Buyer(
      companyName: "Nestlé",
      address: "Vevey, Switzerland",
      vatNumber: "123456"),
  Buyer(
      companyName: "Samsung",
      address: "Seoul, South Korea",
      vatNumber: "654321")
];

PaymentDetails paymentDetails = PaymentDetails(
  paymentTerms: "30 days",
  paymentMethod: "Bank Transfer",
  dueDate: DateTime.now().add(const Duration(days: 30)),
);
List<InvoiceItem> selecteditems = [];

Invoice invoice = Invoice(
  invoiceNumber: "INV-2024-001",
  dateOfIssue: DateTime.now(),
  dateOfSale: DateTime.now().subtract(const Duration(days: 1)),
  sellerdummy: sellerdummy,
  buyer: currentbuyer[0],
  items: selecteditems,
  paymentDetails: paymentDetails,
  remarks: "Thank you for your purchase!",
  totalDue: 0,
  paidamount: 200,
  agentLogo: "assets/barcelona.png",
);

class customdecoration {
  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none, // No default border
      ),
      filled: true,
      fillColor: Colors.grey[300],
      hintText: hintText, // Use the passed hint text
      hintStyle:
          TextStyle(color: Colors.grey[700]), // Optional: style for hint text
    );
  }
}
