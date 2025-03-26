import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/clients_pro.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:pie_menu/pie_menu.dart';

const configUrl = URLs.baseUrl;

const defaultAvatarUrl = '$configUrl/media/avatars/avatar.jpg'; // Zmienna do przechowywania URL domyślnego awatara

class ClientList extends ConsumerWidget {
  const ClientList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientListAsyncValue = ref.watch(clientProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth > 1080 ? screenWidth / 2 : screenWidth;
    return clientListAsyncValue.when(
      data: (clients) {
        if (clients.isEmpty) {
          return Center(
            child: Text(
              'No clients available',
              style: AppTextStyles.interMedium16
                  .copyWith(color: Theme.of(context).iconTheme.color),
            ),
          );
        }
        return ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            final client = clients[index];
            print('hello$client');
            return PieMenu(
              onPressedWithDevice: (kind) {
                if (kind == PointerDeviceKind.mouse ||
                    kind == PointerDeviceKind.touch) {
                  ref.read(navigationService).pushNamedScreen(
                    '${Routes.proClients}/${client.id}/Dashboard',
                    data: {'clientViewPop': client},
                  );
                }
              },
              actions: buildPieMenuActionsClientsPro(
                  ref, client.id, client, context),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: containerWidth,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient:
                          CustomBackgroundGradients.adGradient1(context, ref),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                    client.avatar ?? defaultAvatarUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${client.name} ${client.lastName}',
                                  style: AppTextStyles.interMedium18.copyWith(
                                      color: Theme.of(context).iconTheme.color),
                                ),
                                const SizedBox(height: 5),
                                Text(client.email!,
                                    style: AppTextStyles.interMedium.copyWith(
                                        color:
                                            Theme.of(context).iconTheme.color)),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => SingleChildScrollView(
        child: Column(
          children: List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                height: 80,
                width: containerWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient:
                      CustomBackgroundGradients.crmadgradient(context, ref),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShimmerPlaceholder(width: 60, height: 60),
                    SizedBox(width: 6),
                    Expanded(
                      child: ShimmerPlaceholderwithoutwidth(height: 50),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      error: (err, stack) {
        return SingleChildScrollView(
          child: Column(
            children: List.generate(
              10,
              (index) => Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  height: 80,
                  width: containerWidth,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient:
                        CustomBackgroundGradients.crmadgradient(context, ref),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 6),
                      const Stack(
                        children: [
                          ShimmerPlaceholder(width: 60, height: 60),
                          Positioned(
                              left: 16,
                              top: 16,
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ))
                        ],
                      ),
                      const SizedBox(width: 6),
                      ShimmerPlaceholder(
                          width: (containerWidth) * 0.86, height: 50),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
