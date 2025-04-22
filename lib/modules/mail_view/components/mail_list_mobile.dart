import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/modules/mail_view/components/mail_detail.dart';
import 'package:hously_flutter/modules/mail_view/components/mail_top_bar.dart';
import 'package:hously_flutter/modules/mail_view/utils/api_services.dart';
import 'package:hously_flutter/modules/mail_view/utils/mail_filters.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';

class EmailListWithPreviewMobile extends ConsumerStatefulWidget {
  final int? leadId;
  final Lead? lead;
  
  const EmailListWithPreviewMobile({
  super.key, 
  this.leadId,
  this.lead
  });


  @override
  ConsumerState<EmailListWithPreviewMobile> createState() =>
      _EmailListWithPreviewState();
}

class _EmailListWithPreviewState extends ConsumerState<EmailListWithPreviewMobile> {
  int? selectedEmailId;

@override
void initState() {
  super.initState();

  // Poczekaj na zakończenie cyklu budowania i ustaw/wyczyść leadId
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final notifier = ref.read(mailLeadIdProvider.notifier);
    if (widget.leadId != null) {
      notifier.state = widget.leadId;
    } else {
      notifier.state = null;
    }
  });
}


@override
void dispose() {
  ref.read(mailLeadIdProvider.notifier).state = null;
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    final emailsAsync = ref.watch(filteredEmailsProvider);
    final page = ref.watch(mailPageProvider);
    final pageSize = ref.watch(mailPageSizeProvider);
    final double screenSize = MediaQuery.of(context).size.width;

    return Row(
      children: [
           Container(
            width:screenSize* 2/3,
            color: AppColors.light5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MailTopBar(),
                Expanded(
                  child: emailsAsync.when(
                    data: (data) {
                      final emails = data.results;
                      return ListView.builder(
                        itemCount: emails.length,
                        itemBuilder: (context, index) {
                          final email = emails[index];
                          final isSelected = email.id == selectedEmailId;

                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextButton(
                              style: buildSelectEmail(isSelected),
                              onPressed: () {
                                setState(() => selectedEmailId = email.id);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(email.subject,
                                          style: AppTextStyles.interSemiBold16),
                                      const SizedBox(height: 4),
                                      Text(email.sender,
                                          style: AppTextStyles.interLight14),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(
                      child:
                          Text('Błąd: $e', style: AppTextStyles.interLight14),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.chevron_left,
                            color: AppColors.light),
                        onPressed: page > 1
                            ? () => ref.read(mailPageProvider.notifier).state--
                            : null,
                      ),
                      Text('$page', style: AppTextStyles.interLight14),
                      IconButton(
                        icon: Icon(Icons.chevron_right, color: AppColors.light),
                        onPressed: () =>
                            ref.read(mailPageProvider.notifier).state++,
                      ),
                      Spacer(),
                      DropdownButton<int>(
                        value: pageSize,
                        dropdownColor: AppColors.dark,
                        items: const [10, 25, 50, 100]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text('$e',
                                      style: AppTextStyles.interLight14),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            ref.read(mailPageSizeProvider.notifier).state = val;
                            ref.read(mailPageProvider.notifier).state = 1;
                          }
                        },
                      ),
                      
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),

        // Podgląd wiadomości
        Container(
          width: screenSize,
          child: selectedEmailId == null
              ? Center(
                  child: Text('Wybierz wiadomość',
                      style: AppTextStyles.interLight14),
                )
              : EmailDetail(emailId: selectedEmailId!),
        ),
      ],
    );
  }
}
