import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/crm/view/card/client_card_pc.dart';
import 'package:hously_flutter/widgets/crm/view/card/transactions_buttons.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_clientview_content.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_transaction.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/comment/comment_section_pc.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/saved_search_client/saved_seaches_list.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/saved_search_client/saved_search_section_pc.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/transactions/transactions_section.dart';

class ClientViewContent extends StatelessWidget {
  final String activeSection;
  final dynamic clientViewPop;
  final String activeAd;
  final String? openTransaction; // Dodaj to pole

  const ClientViewContent({
    super.key,
    required this.activeSection,
    required this.clientViewPop,
    required this.activeAd,
    required this.openTransaction,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return Column(
      children: [
        if (activeSection == 'Dashboard') ...[
          ClientDashboardContent(clientViewPop: clientViewPop)
        ],
        if (activeSection == 'Komentarze') ...[
          CommentSectionPc(id: clientViewPop.id ?? 0),
        ],
        if (activeSection == 'Transakcje') ...[
          //  const NewClientTransaction(),
          TransactionSectionPc(
            id: clientViewPop.id,
            activeSection: activeSection,
            selectedTransactionId:
                openTransaction, // Przekaż ID wybranej transakcji
            activeAd: activeAd,
          ),
        ],
        if (activeSection == 'Docs') ...[
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: screenWidth / 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: CommentSectionPc(id: clientViewPop.id),
                ),
              ),
            ),
          ),
        ],
        if (activeSection == 'Wyszukiwania') ...[
          SaveSearchByClientListViewWidget(clientId: clientViewPop.id),
        ],
      ],
    );
  }
}
