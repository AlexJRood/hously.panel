import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/components/client_text_styles.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/const.dart';

class NewClientMobileTransaction extends ConsumerWidget {
  final int id;

  final dynamic data;
  const NewClientMobileTransaction({
    super.key,
    required this.id,
    required this.data,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.clientTilecolor,
        borderRadius: BorderRadius.circular(5),
      ),
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  ref.read(navigationService).pushNamedScreen(
                    '${Routes.proClients}/${id}/dashboard/$index',
                    data: {'clientViewPop': data},
                  );
                },
                child: Row(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction['amount']!,
                            style: customtextStyle(context, ref),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            '${transaction['amounteuro']!} EUR',
                            style: textStylesubheading(context, ref),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color:
                    const Color.fromARGB(255, 109, 109, 109).withOpacity(0.2),
              ),
            ],
          );
        },
      ),
    );
  }
}
