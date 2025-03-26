import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/clients_pro.dart';
import 'package:pie_menu/pie_menu.dart';

const configUrl = URLs.baseUrl;
const defaultAvatarUrl = '$configUrl/media/avatars/avatar.jpg';

class ClientList extends ConsumerWidget {
  final bool isMobile;
  const ClientList({super.key, this.isMobile = false});

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
              style: AppTextStyles.interMedium16.copyWith(
                color: Colors.white,
              ),
            ),
          );
        }

        return Container(
          color: isMobile
              ? const Color.fromRGBO(19, 19, 19, 1)
              : const Color.fromRGBO(30, 30, 30, 1),
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  color: const Color.fromRGBO(40, 40, 40, 1),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3, child: Text('Name', style: _headerStyle)),
                      Expanded(child: Text('Type', style: _headerStyle)),
                      Expanded(child: Text('Status', style: _headerStyle)),
                      Expanded(
                          flex: 2, child: Text('Email', style: _headerStyle)),
                      Expanded(
                          child: Text('Phone Number', style: _headerStyle)),
                      const SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color.fromRGBO(50, 50, 50, 1)),
              ],

              Expanded(
                child: ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];

                    if (isMobile) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(40, 40, 40, 1),
                        ),
                        child: ExpansionTile(
                          tilePadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          collapsedBackgroundColor:
                              const Color.fromRGBO(19, 19, 19, 1),
                          backgroundColor:
                              const Color.fromRGBO(87, 148, 221, 0.1),
                          iconColor: Colors.white54,
                          leading: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(145, 145, 145, 1),
                          ),
                          showTrailingIcon: false,
                          collapsedIconColor: Colors.white54,
                          title: Text(
                            '${client.name} ${client.lastName}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          children: [
                            ListTile(
                              title: const Text(
                                'Status',
                                style: TextStyle(color: Colors.white54),
                              ),
                              trailing: Text(
                                client.contactType ?? '-',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(161, 236, 230, 1),
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                'Email',
                                style: TextStyle(color: Colors.white54),
                              ),
                              trailing: Text(
                                client.email ?? '-',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(161, 236, 230, 1),
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                'Phone',
                                style: TextStyle(color: Colors.white54),
                              ),
                              trailing: Text(
                                client.phoneNumber ?? '-',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(161, 236, 230, 1),
                                ),
                              ),
                            ),
                            const Divider(color: Colors.white12),
                            InkWell(
                              onTap: () {
                                ref.read(navigationService).pushNamedScreen(
                                  '${Routes.proClients}/${client.id}/Dashboard',
                                  data: {'clientViewPop': client},
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.remove_red_eye,
                                        color: Colors.white),
                                    Text(
                                      "View profile",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          color: const Color.fromRGBO(30, 30, 30, 1),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '${client.name} ${client.lastName}',
                                  style: _rowTextStyle,
                                ),
                              ),
                              Expanded(
                                  child: Text(client.contactType ?? '-',
                                      style: _rowTextStyle)),
                              Expanded(
                                  child: Text(client.serviceType ?? '-',
                                      style: _rowTextStyle)),
                              Expanded(
                                  flex: 2,
                                  child: Text(client.email ?? '-',
                                      style: _rowTextStyle)),
                              Expanded(
                                  child: Text(client.phoneNumber ?? '-',
                                      style: _rowTextStyle)),
                              IconButton(
                                icon: const Icon(Icons.more_vert,
                                    color: Colors.white54),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              // Footer Pagination
              if (!isMobile)
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  color: const Color.fromRGBO(30, 30, 30, 1),
                  child: Row(
                    children: [
                      Text('Showing ${clients.length} out of ${clients.length}',
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 12)),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.chevron_left,
                            color: Colors.white54),
                        onPressed: () {},
                      ),
                      const Text('1', style: TextStyle(color: Colors.white)),
                      IconButton(
                        icon: const Icon(Icons.chevron_right,
                            color: Colors.white54),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
      loading: () =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
      error: (err, stack) {
        return Center(
          child: Text(
            'Error loading clients',
            style: AppTextStyles.interMedium16.copyWith(color: Colors.red),
          ),
        );
      },
    );
  }

  TextStyle get _headerStyle => const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );

  TextStyle get _rowTextStyle => const TextStyle(
        color: Colors.white,
        fontSize: 14,
      );
}
