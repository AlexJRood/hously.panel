import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/crm/client_tile.dart';

class TopAppBarCRMWithBack extends ConsumerWidget {
  final String routeName;

  const TopAppBarCRMWithBack({super.key, required this.routeName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxLogoSize = 30;
    const double minLogoSize = 16;

    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: AppColors.light),
                    onPressed: () => ref.read(navigationService).beamPop(),
                  ),
                ),
              ),
              Expanded(child: ClientListAppBar(routeName: routeName)),
              TextButton(
                onPressed: () {
                  BetterFeedback.of(context).show(
                    (feedback) async {
                      // upload to server, share whatever
                      // for example purposes just show it to the user
                      // alertFeedbackFunction(
                      // context,
                      // feedback,
                      // );
                    },
                  );
                },
                child: Text(
                  'HOUSLY',
                  style:
                      AppTextStyles.houslyAiLogo.copyWith(fontSize: logoSize),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
