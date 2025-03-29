import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/modules/mail_view/components/mail_list.dart';
import 'package:hously_flutter/modules/mail_view/send_mail/send_mail.dart';
import 'package:hously_flutter/modules/mail_view/utils/mail_filters.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/widgets/bars/bar_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/modules/mail_view/components/mail_top_bar.dart';
import 'package:hously_flutter/modules/mail_view/utils/api_services.dart';



class EmailView extends ConsumerWidget {
  final int? leadId;
  final Lead? lead;

  EmailView({
  super.key, 
  this.leadId,
  this.lead
  });


  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  int? selectedEmailId;

    final sync = ref.watch(syncEmailsProvider);
    final selectedType = ref.watch(mailTypeProvider);
    if(leadId != null)
      final emailsAsync = ref.watch(emailsByLeadProvider(leadId!));

    
    Widget buildFilterButton(String label, String value) {
      final isSelected = selectedType == value;

      return Container(
        padding: EdgeInsets.all(5),
        height:50,
        width: double.infinity,
        child: TextButton(
              style: buildEmailButtonStyle(isSelected), // ← dodaj to!
              onPressed: () {
                ref.read(mailTypeProvider.notifier).state = value;
                ref.read(mailPageProvider.notifier).state = 1;
              },
              
              child: Text(label, style: AppTextStyles.interLight14),
        
          ),
      );
    }


    Widget buildSortButton() {

        return Container(
                 padding: EdgeInsets.all(5),
                 height:50,
                 width: double.infinity,
                  child: DropdownButton<String>(
                    dropdownColor: AppColors.dark,
                    value: ref.watch(mailSortProvider),
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(mailSortProvider.notifier).state = value;
                        ref.read(mailPageProvider.notifier).state = 1; // reset page
                      }
                    },
                    items: [
                      DropdownMenuItem(value: 'received_at_desc', child: Text('Najnowsze', style: AppTextStyles.interLight14),),
                      DropdownMenuItem(value: 'received_at_asc', child: Text('Najstarsze', style: AppTextStyles.interLight14),),
                      DropdownMenuItem(value: 'subject_asc', child: Text('Temat A-Z', style: AppTextStyles.interLight14),),
                      DropdownMenuItem(value: 'subject_desc', child: Text('Temat Z-A', style: AppTextStyles.interLight14),),
                    ],
                  ),
                );
        }

    return sync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('❌ Błąd synchronizacji: $err')),
      data: (_) {
        return BarManager(
          sideMenuKey: sideMenuKey,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 240,
                    color: AppColors.light15,
                    child: Column(
                      children: [
                        buildSortButton(),
                          buildFilterButton("Wszystkie", "all"),
                          buildFilterButton("Odebrane", "inbox"),
                          buildFilterButton("Wysłane", "sent"),
                          Spacer(), 
                          Container(
                            height: 50,
                            child: ElevatedButton(  
                              style: elevatedButtonStyleRounded10,
                                onPressed: () => showEmailOverlay(context, ref),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.newChat,
                                              height: 25, width: 25, color: AppColors.light),
                                    const SizedBox(width:25),
                                    Text( 'Nowa wiadomość', style: AppTextStyles.interLight14),
                                  ],
                                ),
                              ),
                          ),
                      ],
                    ),
                  ),
                  
                  Expanded(child: EmailListWithPreview(leadId: leadId, lead: lead)),
                  
                  
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
