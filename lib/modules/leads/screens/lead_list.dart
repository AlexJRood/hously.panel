import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/board/board_state.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/widgets/bars/bar_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'dart:math' as math;

class LeadsPage extends ConsumerStatefulWidget {
  const LeadsPage({super.key});

  @override
  ConsumerState<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends ConsumerState<LeadsPage> {
  final sideMenuKey = GlobalKey<SideMenuState>();
  int currentPage = 1;
  Set<int> selectedLeadIds = {};
  bool isAllSelected = false;

  String? getLeadStatusName(int leadId, List<LeadStatus> statuses) {
    for (final status in statuses) {
      if (status.leadIndex.contains(leadId)) {
        return status.statusName;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final leadsAsync = ref.watch(paginatedLeadsProvider(currentPage));
    final boardStateAsync = ref.watch(leadProvider);

    return BarManager(
      sideMenuKey: sideMenuKey,
      isBarHoveroverUI: true,
      children: [
        Expanded(
          child: leadsAsync.when(
            data: (PaginatedLeadResponse data) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;
                  return isWide
                      ? _buildDataTable(data.results, data, boardStateAsync)
                      : _buildMobileList(data.results, data, boardStateAsync);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text('Błąd: $e', style: AppTextStyles.interMedium),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable(List<Lead> leads, PaginatedLeadResponse data,
      AsyncValue<BoardState> boardState) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: 60),
          Container(
            width: double.infinity,
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 32,
              headingRowColor: MaterialStateProperty.all(AppColors.light25),
              columns: [
                DataColumn(
                  label: Checkbox(
                    value: isAllSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isAllSelected = value ?? false;
                        if (isAllSelected) {
                          selectedLeadIds = leads.map((e) => e.id).toSet();
                        } else {
                          selectedLeadIds.clear();
                        }
                      });
                    },
                  ),
                ),

                // DataColumn(label: Text('ID', style: AppTextStyles.interMedium)),
                DataColumn(
                    label: Row(
                      children: [
                        const SizedBox(width: 55),
                        Text('Imię i nazwisko',
                            style: AppTextStyles.interMedium),
                      ],
                    )),
                DataColumn(
                    label: Text('typ', style: AppTextStyles.interMedium)),
                DataColumn(
                    label: Text('',
                        style: AppTextStyles.interMedium)),
                DataColumn(
                    label: Text('Miasto', style: AppTextStyles.interMedium)),
                DataColumn(
                    label: Text('Firma', style: AppTextStyles.interMedium)),
                DataColumn(
                    label: Text('Status', style: AppTextStyles.interMedium)),
                DataColumn(
                    label: Text('Notatka', style: AppTextStyles.interMedium)),
              ],
              rows: leads.map((lead) {
                final statusName = boardState.maybeWhen(
                  data: (state) => getLeadStatusName(lead.id, state.statuses),
                  orElse: () => null,
                );

                return DataRow(
                
                  onSelectChanged: (_) {
                    ref.read(navigationService).pushNamedScreen('${Routes.leadsPanel}/${lead.id}');
                  },
                  cells: [
                    DataCell(
                      Checkbox(
                        value: selectedLeadIds.contains(lead.id),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedLeadIds.add(lead.id);
                              if (selectedLeadIds.length == leads.length) {
                                isAllSelected = true;
                              }
                            } else {
                              selectedLeadIds.remove(lead.id);
                              isAllSelected = false;
                            }
                          });
                        },
                      ),
                    ),

                    // DataCell(Text('${lead.id}', style: AppTextStyles.interMedium)),
                    DataCell(
                      Row(
                        spacing: 15,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 40,
                              height: 40,
                              color: Colors.grey.shade200, // opcjonalne tło
                              child: lead.avatar == null
                                  ? Image.asset(
                                      'assets/images/deafult/man.webp',
                                      fit: BoxFit.cover)
                                  : Image.network(lead.avatar!,
                                      fit: BoxFit.cover),
                            ),
                          ),
                          Text(lead.name, style: AppTextStyles.interMedium),
                        ],
                      ),
                    ),
                    DataCell(Text(lead.companyType ?? 'brak danych',
                        style: AppTextStyles.interMedium)),
                    DataCell(lead.isRegister
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.revenueGreen,
                            ))
                        : Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.expensesRed,
                            ))),

                    DataCell(Text(lead.city ?? 'brak danych',
                        style: AppTextStyles.interMedium)),
                    DataCell(Text(lead.companyName ?? 'brak danych',
                        style: AppTextStyles.interMedium)),
                    DataCell(Text(statusName ?? 'Brak statusu',
                        style: AppTextStyles.interMedium)),
                    DataCell(Text(lead.note ?? '',
                        style: AppTextStyles.interMedium)),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          _buildPagination(data),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMobileList(List<Lead> leads, PaginatedLeadResponse data,
      AsyncValue<BoardState> boardState) {
    return ListView(
      children: [
        const SizedBox(height: 60),
        ...leads.map((lead) {
          final statusName = boardState.maybeWhen(
            data: (state) => getLeadStatusName(lead.id, state.statuses),
            orElse: () => null,
          );

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.transparent,
            child: ListTile(
              title: Text(lead.name, style: AppTextStyles.interMedium),
              subtitle: Row(
                spacing: 15,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.grey.shade200, // opcjonalne tło
                      child: lead.avatar == null
                          ? Image.asset('assets/images/deafult/man.webp',
                              fit: BoxFit.cover)
                          : Image.network(lead.avatar!, fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (lead.companyName != null)
                        Text('Firma: ${lead.companyName}',
                            style: AppTextStyles.interMedium),
                      if (statusName != null)
                        Text('Status: $statusName',
                            style: AppTextStyles.interMedium),
                      if (lead.note != null)
                        Text('Notatka: ${lead.note}',
                            style: AppTextStyles.interMedium),
                    ],
                  ),
                ],
              ),
              onTap: () {
                ref
                    .read(navigationService)
                    .pushNamedScreen('${Routes.leadsPanel}/${lead.id}');
              },
            ),
          );
        }),
        const SizedBox(height: 16),
        _buildPagination(data),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildPagination(PaginatedLeadResponse data) {
    final pageSize = ref.watch(leadPageSizeProvider);
    final options = [10, 17, 25, 50, 100];
    final isMobile = MediaQuery.of(context).size.width < 800;

    return isMobile
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 30,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: currentPage > 1
                          ? () => setState(() => currentPage--)
                          : null,
                      child: Text('← Poprzednia',
                          style: AppTextStyles.interMedium),
                    ),
                    const SizedBox(width: 16),
                    Text(
                        'Strona $currentPage / ${(data.count / pageSize).ceil()}',
                        style: AppTextStyles.interMedium),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: data.next != null
                          ? () => setState(() => currentPage++)
                          : null,
                      child:
                          Text('Następna →', style: AppTextStyles.interMedium),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Wyników ${data.count}',
                        style: AppTextStyles.interMedium),
                    Spacer(),
                    Text('Wyników na stronę: ',
                        style: AppTextStyles.interMedium),
                    const SizedBox(width: 8),
                    DropdownButton<int>(
                      value: pageSize,
                      dropdownColor: AppColors
                          .dark75, // 👈 to ustawia tło rozwijanej listy
                      items: options
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text('$value',
                                  style: AppTextStyles.interMedium),
                            ),
                          )
                          .toList(),
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          ref.read(leadPageSizeProvider.notifier).state =
                              newValue;
                        }
                      },
                      underline: const SizedBox(),
                      style: AppTextStyles.interMedium,
                    ),
                  ],
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 200,
                    child: Text('Wyników ${data.count}',
                        style: AppTextStyles.interMedium)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: currentPage > 1
                          ? () => setState(() => currentPage--)
                          : null,
                      child: Text('← Poprzednia',
                          style: AppTextStyles.interMedium),
                    ),
                    const SizedBox(width: 16),
                    Text(
                        'Strona $currentPage / ${(data.count / pageSize).ceil()}',
                        style: AppTextStyles.interMedium),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: data.next != null
                          ? () => setState(() => currentPage++)
                          : null,
                      child:
                          Text('Następna →', style: AppTextStyles.interMedium),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Text('Wyników na stronę: ',
                          style: AppTextStyles.interMedium),
                      const SizedBox(width: 8),
                      DropdownButton<int>(
                        value: pageSize,
                        dropdownColor: AppColors
                            .dark75, // 👈 to ustawia tło rozwijanej listy
                        items: options
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text('$value',
                                    style: AppTextStyles.interMedium),
                              ),
                            )
                            .toList(),
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            ref.read(leadPageSizeProvider.notifier).state =
                                newValue;
                          }
                        },
                        underline: const SizedBox(),
                        style: AppTextStyles.interMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
