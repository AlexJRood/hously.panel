import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/theme/design/design.dart';

class LeadInteractionsList extends ConsumerWidget {
  final bool isWhiteSpaceNeeded;
  final Lead lead;
  final bool isHidden;

  const LeadInteractionsList({
    super.key,
    required this.isWhiteSpaceNeeded,
    required this.lead, 
    required this.isHidden,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();

    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: isWhiteSpaceNeeded ? 120 : 40),
            ),
            lead.interactions.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          'Brak interakcji dla tego leada.',
                          style: AppTextStyles.interMedium,
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final interaction = lead.interactions[index];
                        return ListTile(
                          title: Text(
                            interaction.interactionType,
                            style: AppTextStyles.interMedium,
                          ),
                          subtitle: Text(
                            interaction.content ?? '',
                            style: AppTextStyles.interLight,
                          ),
                        );
                      },
                      childCount: lead.interactions.length,
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
