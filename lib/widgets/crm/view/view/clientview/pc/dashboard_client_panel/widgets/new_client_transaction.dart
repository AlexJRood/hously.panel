import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/components/client_text_styles.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/components/transaction_filter_button.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/components/transaction_popup.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/transaction_success_tile.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/const.dart';
import 'package:get/get_utils/get_utils.dart';

class NewClientTransaction extends ConsumerStatefulWidget {
  const NewClientTransaction({super.key});

  @override
  ConsumerState<NewClientTransaction> createState() =>
      _NewClientTransactionState();
}

class _NewClientTransactionState extends ConsumerState<NewClientTransaction> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Transakcje".tr,
                    style: headerStyle(context, ref)
                        .copyWith(fontSize: 20, color: theme.whitewhiteblack),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 35,
                    width: 200,
                    child: TextField(
                      style: TextStyle(color: theme.textFieldColor),
                      decoration: InputDecoration(
                          fillColor: theme.fillColor,
                          suffixIcon: Icon(
                            Icons.search,
                            color: theme.textFieldColor,
                          ),
                          hintText: 'Szukaj...'.tr,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: theme.textFieldColor,
                          ),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TransactionFilterButton(
                      isicon: true, text: 'Filtruj'.tr, onTap: () {}),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    flex: 22,
                    child: Text('Project', style: headerStyle(context, ref))),
                Expanded(
                    flex: 8,
                    child: Text('Typ'.tr, style: headerStyle(context, ref))),
                Expanded(
                    flex: 10,
                    child: Text('Status', style: headerStyle(context, ref))),
                Expanded(
                    flex: 8,
                    child: Text('Kwota'.tr, style: headerStyle(context, ref))),
                Expanded(
                    flex: 9,
                    child: Text('Prowizja'.tr, style: headerStyle(context, ref))),
                Expanded(
                    flex: 8,
                    child: Text('Date', style: headerStyle(context, ref))),
                Expanded(
                    flex: 8,
                    child: Text('Metoda'.tr, style: headerStyle(context, ref))),
                const Expanded(flex: 5, child: SizedBox()),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            Divider(color: Theme.of(context).dividerColor),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 22,
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    'assets/images/image.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction['project']!,
                                        style: customtextStyle(context, ref),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines:
                                            1, // Truncates text to prevent overflow
                                      ),
                                      Text(
                                        transaction['location']!,
                                        style: textStylesubheading(context, ref),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines:
                                            1, // Truncates text to prevent overflow
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 8,
                              child: Text(transaction['type']!,
                                  style: customtextStyle(context, ref))),
                          Expanded(
                              flex: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Paymentstatuscontainer(
                                        status: transaction['status']!),
                                  ),
                                  const Expanded(flex: 2, child: SizedBox())
                                ],
                              )),
                          Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transaction['amount']!,
                                      style: customtextStyle(context, ref)),
                                  Text(
                                    '${transaction['amounteuro']!} EUR',
                                    style: textStylesubheading(context, ref),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transaction['commission']!,
                                      style: customtextStyle(context, ref)),
                                  Text(
                                    '${transaction['commisioneuro']!} EUR',
                                    style: textStylesubheading(context, ref),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 8,
                              child: Text(transaction['date']!,
                                  style: customtextStyle(context, ref))),
                          Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transaction['method']!,
                                      style: customtextStyle(context, ref)),
                                  Text(
                                    transaction['cardno']!,
                                    style: textStylesubheading(context, ref),
                                  )
                                ],
                              )),
                          const Expanded(flex: 5, child: Customiconbuttom()),
                        ],
                      ),
                      Divider(
                          color: const Color.fromARGB(255, 109, 109, 109)
                              .withOpacity(0.2)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
