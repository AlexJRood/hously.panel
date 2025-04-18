import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/widgets/bars/bar_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';


class LeadsPage extends ConsumerStatefulWidget {
  const LeadsPage({super.key});

  @override
  ConsumerState<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends ConsumerState<LeadsPage> {
    final sideMenuKey = GlobalKey<SideMenuState>();
  int currentPage = 1;
  int pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final leadsAsync = ref.watch(paginatedLeadsProvider(currentPage));

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
                      ? Column(
                        children: [
                        _buildDataTable(data.results),
                        Spacer(),
                        _buildPagination(data),
                        ],
                      )
                      : _buildMobileList(data.results, data);
                        
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



  Widget _buildDataTable(List<Lead> leads) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
            const SizedBox(height: 60),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DataTable(
              columnSpacing: 32,
              headingRowColor: MaterialStateProperty.all(AppColors.dark25),
              columns: [
                DataColumn(label: Text('ID', style: AppTextStyles.interMedium)),
                DataColumn(label: Text('Imię', style: AppTextStyles.interMedium)),
                DataColumn(label: Text('Firma', style: AppTextStyles.interMedium)),
                DataColumn(label: Text('Status', style: AppTextStyles.interMedium)),
                DataColumn(label: Text('Notatka', style: AppTextStyles.interMedium)),
              ],
              rows: leads.map((lead) {
                return DataRow(
                  onSelectChanged: (_) {
                    ref.read(navigationService).pushNamedScreen('${Routes.leadsPanel}/${lead.id}');
                  },
                  cells: [
                    DataCell(Text('${lead.id}', style: AppTextStyles.interMedium)),
                    DataCell(Text(lead.name, style: AppTextStyles.interMedium)),
                    DataCell(Text(lead.companyName ?? '-',
                        style: AppTextStyles.interMedium)),
                    DataCell(Text(lead.status?.statusName ?? 'Brak',
                        style: AppTextStyles.interMedium)),
                    DataCell(
                        Text(lead.note ?? '', style: AppTextStyles.interMedium)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildMobileList(List<Lead> leads, PaginatedLeadResponse data) {
  return ListView(
    children: [
      const SizedBox(height: 60), 

      ...leads.map((lead) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.transparent,
            child: ListTile(
              title: Text(lead.name, style: AppTextStyles.interMedium),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (lead.companyName != null)
                    Text('Firma: ${lead.companyName}',
                        style: AppTextStyles.interMedium),
                  if (lead.status != null)
                    Text('Status: ${lead.status!.statusName}'),
                  if (lead.note != null)
                    Text('Notatka: ${lead.note}',
                        style: AppTextStyles.interMedium),
                ],
              ),
            ),
          )),

      const SizedBox(height: 16),
      _buildPagination(data), // <-- na dole paginacja
    ],
  );
}


  Widget _buildPagination(PaginatedLeadResponse data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed:
              currentPage > 1 ? () => setState(() => currentPage--) : null,
          child: Text('← Poprzednia', style: AppTextStyles.interMedium),
        ),
        const SizedBox(width: 16),
        Text('Strona $currentPage', style: AppTextStyles.interMedium),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed:
              data.next != null ? () => setState(() => currentPage++) : null,
          child: Text('Następna →', style: AppTextStyles.interMedium),
        ),
      ],
    );
  }
}
