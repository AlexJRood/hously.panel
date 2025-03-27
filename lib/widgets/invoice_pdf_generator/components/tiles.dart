import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/components/customitempicker.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/const.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/model/invoise_model.dart';

class RowCreator extends ChangeNotifier {
  final int index;
  final VoidCallback? onDelete; // Callback for deleting the row
  final Function(double) onTotalUpdate; // Callback for updating the total value

  RowCreator({
    required this.index,
    this.onDelete,
    required this.onTotalUpdate, // Make the callback required
  });

  InvoiceItem? chooseditem;
  String? description;
  double? varrate;
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController vat = TextEditingController();

  // Function to handle item selection
  void invoiceItemSelection(InvoiceItem currentItem) {
    description = currentItem.description;
    quantity.text = '1';
    varrate = currentItem.vatRate;
    vat.text = "${double.tryParse(varrate.toString())}";
    price.text = currentItem.netUnitPrice.toString();
    notifyListeners();
    _updateRowData();
    _updateTotal(); // Update total when item is selected
  }

  void _updateTotal() {
    // Calculate total price
    double total = 0.0;
    for (var item in selecteditems) {
      double netAmount = item.netUnitPrice * item.quantity;
      double vatAmount = netAmount * (item.vatRate / 100);
      total += netAmount + vatAmount;
    }

    // Call the callback with the new total
    onTotalUpdate(total);
  }

  Widget buildRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                index == 0
                    ? const Text(
                        "Products",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                ProductSearchField(
                  productlist: itemlist,
                  onInvoiseselect: invoiceItemSelection,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                index == 0
                    ? const Text(
                        "Qty",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  decoration: customdecoration().customInputDecoration('Qty'),
                  controller: quantity,
                  onChanged: (event) {
                    _updateRowData();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                index == 0
                    ? const Text(
                        "Price",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: customdecoration().customInputDecoration('Price'),
                  controller: price,
                  onChanged: (event) {
                    _updateRowData();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                index == 0
                    ? const Text(
                        "Vat %",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: customdecoration().customInputDecoration('Vat %'),
                  controller: vat,
                  onChanged: (event) {
                    _updateRowData();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                index == 0
                    ? const Text(
                        "Amount",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration:
                      customdecoration().customInputDecoration('Amount'),
                  controller: amount,
                  readOnly: true,
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Column(
            children: [
              index == 0
                  ? SizedBox(
                      height: 27,
                    )
                  : SizedBox(
                      height: 10,
                    ),
              IconButton(
                onPressed: onDelete,
                icon:  SvgPicture.asset(AppIcons.delete,color: Colors.black ,),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateRowData() {
    var realquantity = int.tryParse(quantity.text) ?? 1;
    var priceValue = double.tryParse(price.text) ?? 0.0;
    var vatRate = double.tryParse(vat.text) ?? 0.0;

    var netAmount = realquantity * priceValue;
    var vatAmount = netAmount * (vatRate / 100);
    amount.text = (netAmount + vatAmount).toString();

    if (index < selecteditems.length) {
      selecteditems[index] = InvoiceItem(
        description: description!,
        quantity: realquantity,
        netUnitPrice: priceValue,
        vatRate: vatRate,
      );
    } else {
      selecteditems.add(InvoiceItem(
        description: description!,
        quantity: realquantity,
        netUnitPrice: priceValue,
        vatRate: vatRate,
      ));
    }

    // Update the total
    _updateTotal();
  }
}
