import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/custom_containers.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/const.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/transaction_success_tile.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  late int transactionId;
  Map<String, String>? transaction;

  @override
  void initState() {
    super.initState();
    transactionId = extractIdFromUrl(Uri.base.toString()); // Get ID from URL
    transaction = getTransactionById(transactionId); // Fetch transaction data
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final isDark = ref.watch(isDefaultDarkSystemProvider);
    if (transaction == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Transaction Details")),
        body: const Center(
          child: Text("Transaction not found",
              style: TextStyle(color: Colors.red)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.clientbackground,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(100)),
                  gradient: CustomBackgroundGradients.getMainMenuBackground(
                      context, ref)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                        onPressed: () {
                          ref.read(navigationService).beamPop();
                        },
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const Spacer(),
                      Text(
                        "Details",
                        style: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        transaction!['date'] ?? '',
                        style: TextStyle(
                            color: Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(0.7),
                            fontSize: 14),
                      ),
                      Text(
                        ". 8:53",
                        style: TextStyle(
                            color: Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(0.7),
                            fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Last updated",
                    style: TextStyle(
                        color:
                            Theme.of(context).iconTheme.color!.withOpacity(0.7),
                        fontSize: 10),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    transaction!['amount'] ?? '',
                    style: TextStyle(
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(0.7),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: theme.clientTilecolor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xff5a5a5a))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.credit_card_rounded,
                                  color: theme.whitewhiteblack),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  transaction!['project'] ?? '',
                                  style: TextStyle(
                                      color: theme.whitewhiteblack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TransactionRow(
                              title: "Type", value: transaction!['type'] ?? ''),
                          TransactionRow(
                              title: "Status",
                              value: Paymentstatuscontainer(
                                status: transaction!['status']!,
                              ),
                              isStatus: true),
                          TransactionRow(
                              title: "Amount",
                              value:
                                  "${transaction!['amounteuro']} = ${transaction!['amount']}"),
                          TransactionRow(
                              title: "Commission",
                              value:
                                  "${transaction!['commisioneuro']} = ${transaction!['commission']}"),
                          TransactionRow(
                              title: "Method",
                              value: transaction!['cardno'] ?? ''),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "View Advertisement",
                                  style: TextStyle(
                                      color: isDark
                                          ? clienttileTextcolor
                                          : Theme.of(context).primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  transaction!['status'] != "Success"
                      ? Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: theme.clientTilecolor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xff5a5a5a),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Notes",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: theme.whitewhiteblack),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(color: Colors.grey),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    // Ensures the text can wrap within its parent
                                    child: Text(
                                      transaction!['reason']!,
                                      maxLines:
                                          3, // Limits to 3 lines (adjust as needed)
                                      overflow: TextOverflow
                                          .ellipsis, // Shows "..." if the text exceeds 3 lines
                                      softWrap:
                                          true, // Ensures text wraps properly
                                      style: TextStyle(
                                        color: theme.whitewhiteblack,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Extracts the transaction ID from the URL
  int extractIdFromUrl(String url) {
    Uri uri = Uri.parse(url);
    List<String> segments = uri.pathSegments;
    int dashboardIndex = segments.indexOf("dashboard");
    if (dashboardIndex != -1 && dashboardIndex + 1 < segments.length) {
      print('${int.tryParse(segments[dashboardIndex + 1]) ?? 0}');
      return int.tryParse(segments[dashboardIndex + 1]) ?? 0;
    }
    return 0;
  }

  /// Fetch transaction by ID (1-based index)
  Map<String, String>? getTransactionById(int id) {
    if (id >= 0 && id <= transactions.length) {
      return transactions[id];
    }
    return null;
  }

  /// Widget for displaying rows
}

class TransactionRow extends ConsumerWidget {
  final String title;
  final dynamic value;
  final bool isStatus;

  const TransactionRow({
    Key? key,
    required this.title,
    required this.value,
    this.isStatus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: theme.whitewhiteblack),
          ),
          isStatus
              ? value
              : Text(
                  value,
                  style: TextStyle(color: theme.whitewhiteblack),
                ),
        ],
      ),
    );
  }
}
