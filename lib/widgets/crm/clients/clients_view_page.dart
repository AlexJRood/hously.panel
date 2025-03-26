import 'package:flutter/material.dart';

import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/old/clients_view_mid.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/ad_view_client/clients_view_mobile.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/new_client_mobile.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/new_clients_view_full.dart';

class ClientsViewPop extends StatelessWidget {
  final dynamic clientViewPop;
  final String tagClientViewPop;
  final String activeSection;
  final String activeAd;

  const ClientsViewPop({
    super.key,
    required this.clientViewPop,
    required this.tagClientViewPop,
    required this.activeSection,
    required this.activeAd,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Sprawdzenie, czy szerokość ekranu jest większa niż 1200 px
        if (constraints.maxWidth > 1020) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // Użycie 'widget.adFeedPop' i 'widget.tagFeedPop' do przekazania danych
                child: NewClientsViewFull(
                  clientViewPop: clientViewPop,
                  tagClientViewPop: tagClientViewPop,
                  activeSection: activeSection,
                  activeAd: activeAd,
                ),
              ),
            ],
          );
        }
        
         else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // Użycie 'widget.adFeedPop' i 'widget.tagFeedPop' do przekazania danych
                child: NewClientMobile(
                  clientViewPop: clientViewPop,
                  tagClientViewPop: tagClientViewPop,
                  activeSection: activeSection,
                  activeAd: activeAd,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
