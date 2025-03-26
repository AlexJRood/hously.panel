import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
import 'package:hously_flutter/widgets/crm/clients/clients_list.dart';
import 'package:hously_flutter/widgets/crm/clients/search_buttons.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/model/invoise_model.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/preview/preview_invoice.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_crm.dart';
import 'package:hously_flutter/widgets/crm/view/view/buttons.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_crm.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class ClientsPc extends ConsumerWidget {
  const ClientsPc({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    final sideMenuKey = GlobalKey<SideMenuState>();
    final toggle = ref.watch(invoicetoggleProvider);
    return Scaffold(
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: CustomBackgroundGradients.customcrmright(context, ref)),
          child: Stack(
            children: [
              Row(
                children: [
                  SidebarAgentCrm(sideMenuKey: sideMenuKey),
                  Expanded(
                    child: Column(
                      children: [
                        const TopAppBarCRM(routeName: Routes.proClients),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: screenWidth / 2,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      StatusFilterWidget(),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Flexible(child: ClientList()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: Align(
                    alignment: Alignment.topRight,
                    child: ClientsCrmSideButtons(ref: ref)),
              ),
              if (toggle) ...[const FloatingInvoicePage()]
            ],
          ),
        ),
      ),
    );
  }
}
