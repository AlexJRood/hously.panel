import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/add_client_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/sell_widget.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/view_widget.dart';
import 'buy_widget.dart';

class GetSelectedWidget extends ConsumerWidget {

  final GlobalKey<FormState> sellFormKey;
  final GlobalKey<FormState> buyFormKey;
  final bool isMobile;
  const GetSelectedWidget(
      {super.key,
      required this.sellFormKey,
      required this.buyFormKey,

      this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);
    switch (selectedTab) {
      case 'VIEW':
        return ViewWidget(
          isMobile: isMobile,
        );
      case 'SELL':
        return SellWidget(
          formKey: sellFormKey,
          isMobile: isMobile,
        );
      case 'BUY':
        return BuyWidget(
          buyFormKey: buyFormKey,
          isMobile: isMobile,
        );
      default:
        return const SizedBox();
    }
  }
}
