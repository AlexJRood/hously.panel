import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/clients_pro.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:shimmer/shimmer.dart';

import '../../state_managers/data/crm/clients/client_provider.dart';

class ClientTileMobile extends ConsumerWidget {
  const ClientTileMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    const defaultAvatarUrl =
        'https://www.hously.cloud/media/avatars/avatar_PvxQuoF.jpg'; // Zmienna do przechowywania URL domyślnego awatara
    final clientListAsyncValue = ref.watch(clientProvider);
    ScrollController _scrollController = ScrollController();
    return clientListAsyncValue.when(
      data: (clients) {
        if (clients.isEmpty) {
          return Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: CustomBackgroundGradients.adGradient1(context, ref),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text('No clients available',
                      style: AppTextStyles.interRegular12)),
            ),
          );
        }
        return DragScrollView(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...clients.map((client) {
                    return PieMenu(
                      onPressedWithDevice: (kind) {
                        if (kind == PointerDeviceKind.mouse ||
                            kind == PointerDeviceKind.touch) {
                          ref
                              .read(navigationService)
                              .pushNamedScreen(Routes.proAddClient);
                        }
                      },
                      actions: buildPieMenuActionsClientsPro(
                          ref, client.id, client, context),
                      child: GestureDetector(
                        onTap: () {
                          // Handle client-specific tap logic
                          ref
                              .read(navigationService)
                              .pushNamedScreen(Routes.proAddClient);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  client.avatar ?? defaultAvatarUrl),
                              child: client.avatar == null
                                  ? SvgPicture.asset(AppIcons.search,
                                      color: Theme.of(context).iconTheme.color)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ));
      },
      loading: () => DragScrollView(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              15, // Number of shimmer placeholders
              (index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: ShimmerPlaceholder(
                  height: 65,
                  width: 65,
                  radius: 50,
                ),
              ),
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => Center(
        child:
            Text('Error loading clients', style: AppTextStyles.interRegular12),
      ),
    );
  }
}
