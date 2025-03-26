import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/model/invoise_model.dart';

class ProductSearchField extends StatefulWidget {
  //final Function(InvoiceItem cuurentproduct) onCustomerchange;
  final Function(InvoiceItem invitem) onInvoiseselect;
  final List<InvoiceItem> productlist;

  const ProductSearchField({
    required this.onInvoiseselect,
    //  required this.onCustomerchange,
    required this.productlist,
    Key? key,
  }) : super(key: key);

  @override
  _ProductSearchFieldState createState() => _ProductSearchFieldState();
}

class _ProductSearchFieldState extends State<ProductSearchField> {
  InvoiceItem? selected; // To store the selected buyer
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<InvoiceItem>(
              iconStyleData: const IconStyleData(
                icon: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.keyboard_arrow_down_sharp),
                ),
              ),
              hint:
                  const Text('Select a product'),
              value: selected,
              isExpanded: true, 

              items: [
                ...widget.productlist.map((InvoiceItem products) {
                  return DropdownMenuItem<InvoiceItem>(
                    value: products,
                    child: Text(products.description),
                  );
                }).toList(),
              ],
              onChanged: (InvoiceItem? selectedproduct) {
            
                setState(() {
                  selected = selectedproduct;
                  widget.onInvoiseselect(selected!);

                 
                });
              },
            
            ),
          ),
        ));
  }

 
}
