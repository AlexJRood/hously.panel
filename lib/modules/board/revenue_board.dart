
// import 'package:hously_flutter/modules/board/columns_revenue.dart';
// import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
// import 'package:hously_flutter/routing/navigation_service.dart';
// import 'package:hously_flutter/routing/route_constant.dart';
// import 'package:hously_flutter/utils/custom_error_handler.dart';
// import 'package:hously_flutter/utils/platforms/html_utils_stub.dart'
//     if (dart.library.html) 'package:hously_flutter/utils/platforms/html_utils_web.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get_utils/get_utils.dart';


// class CrmRevenueBoard extends ConsumerStatefulWidget {
//   final WidgetRef ref;

//   const CrmRevenueBoard({super.key, required this.ref});

//   @override
//   _CrmRevenueBoardState createState() => _CrmRevenueBoardState();
// }

// class _CrmRevenueBoardState extends ConsumerState<CrmRevenueBoard> {
//   void _openTransaction(Lead transaction) {
//     int? clientId = transaction.id;

//     if (clientId != null) {
//       // Pobierz obiekt klienta na podstawie clientId
//       fetchClientById(clientId).then((client) {
//         ref.read(navigationService).pushNamedScreen(Routes.clientsViewFull);

//         // Aktualizacja URL
//       updateUrl('/pro/clients/$clientId/Transakcje/${transaction.id}');
      
//       }).catchError((error) {
//         final snackBar = Customsnackbar().showSnackBar(
//             "Error", 'Błąd podczas pobierania klienta: $error'.tr, "error", () {
//           fetchClientById(clientId);
//         });
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       });
//     } else {
//       // Obsłuż sytuację, gdy clientId jest null
//       final snackBar = Customsnackbar().showSnackBar(
//           "Warning",
//           'Nie można otworzyć transakcji: brak powiązanego klienta.'.tr,
//           "warning", () {
//         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       });
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }


//   void onReorder(Lead transaction, int newIndex) {
//     setState(() {
//       final currentState = ref.read(transactionProvider);
//       currentState.whenData((data) {
//         final status = data.statuses.firstWhereOrNull(
//             (status) => status.transactionIndex.contains(transaction.id));

//         if (status == null) {
//             print("Nie znaleziono statusu dla transakcji ID: ${transaction.id}");
//             return;
//         }


//         final oldIndex = status.transactionIndex.indexOf(transaction.id);

//         // Usuwamy element ze starej pozycji
//         final removedTransactionId = status.transactionIndex.removeAt(oldIndex);

//         // Wstawiamy element na nową pozycję
//         if (newIndex > oldIndex) {
//           newIndex -=
//               1; // Kompensujemy przesunięcie, gdy usuwamy element z listy
//         }
//         status.transactionIndex.insert(newIndex, removedTransactionId);

//         // Aktualizujemy stan w providerze
//         ref
//             .read(transactionProvider.notifier)
//             .reorderTransaction(oldIndex, newIndex, status.statusName);
//       });

//       // Logowanie po zaktualizowaniu stanu
//       print('Updated state in onReorder: ${ref.read(transactionProvider).whenData((data) => data.statuses.firstWhere((status) => status.transactionIndex.contains(transaction.id)).transactionIndex)}');
//     });
//   }

//   void onMove(Lead transaction, String newStatus, int? newIndex) {
//     ref
//         .read(transactionProvider.notifier)
//         .moveTransaction(transaction, newStatus, newIndex);
//   }

//   void onAcceptColumn(String movedStatus, String targetStatus) {
//     setState(() {
//       final currentState = ref.read(transactionProvider);
//       currentState.whenData((data) {
//         final oldIndex =
//             data.statuses.indexWhere((s) => s.statusName == movedStatus);
//         final newIndex =
//             data.statuses.indexWhere((s) => s.statusName == targetStatus);

//         if (oldIndex != -1 && newIndex != -1) {
//           final movedItem = data.statuses.removeAt(oldIndex);
//           data.statuses.insert(newIndex, movedItem);

//           // Aktualizuj stan w providerze
//           ref.read(transactionProvider.notifier).reorderStatuses(data.statuses);
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final transactionStateAsync = ref.watch(transactionProvider);

//     return transactionStateAsync.when(
//       data: (data) {
//         final transactionsMap = {for (var tx in data.transactions) tx.id: tx};

//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: data.statuses.map((status) {
//               final filteredTransactions = status.transactionIndex
//                   .map((id) => transactionsMap[id])
//                   .where((tx) => tx != null)
//                   .cast<Lead>()
//                   .toList();

//               return DraggableColumn(
//                 key: ValueKey(status.statusName),
//                 status: status.statusName,
//                 transactions: filteredTransactions,
//                 onAcceptColumn: (movedStatus) =>
//                     onAcceptColumn(movedStatus, status.statusName),
//                 onReorder: (transaction, newIndex) =>
//                     onReorder(transaction, newIndex), // Poprawka argumentów
//                 onMove: (transaction, newStatus, newIndex) =>
//                     onMove(transaction, newStatus, newIndex),
//                 ref: widget.ref,
//                 onTransactionSelected:
//                     _openTransaction, // Dodajemy ten parametr
//               );
//             }).toList(),
//           ),
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, _){
//         print(error);
//         return Center(
//             child: Text('Failed to load transactions and statuses: $error'));
//       },
//     );
//   }

//   void showEditStatusPopup(BuildContext context, WidgetRef ref,
//       {TransactionStatus? status,
//       required Function(TransactionStatus) onSave}) {
//     showDialog(
//       context: context,
//       barrierDismissible:
//           true, // Pozwala na zamknięcie dialogu przez kliknięcie w tło
//       builder: (BuildContext context) {
//         String? statusName = status?.statusName ?? '';
//         int? statusIndex = status?.statusIndex ?? 0;

//         return AlertDialog(
//           title: Text(status != null ? 'Edit Status' : 'New Status'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 initialValue: statusName,
//                 decoration: const InputDecoration(labelText: 'Status Name'),
//                 onChanged: (newValue) {
//                   statusName = newValue;
//                 },
//               ),
//               TextFormField(
//                 initialValue: statusIndex.toString(),
//                 decoration: const InputDecoration(labelText: 'Status Index'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (newValue) {
//                   statusIndex = int.tryParse(newValue) ?? 0;
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () => ref.read(navigationService).beamPop(),
//             ),
//             ElevatedButton(
//               child: const Text('Save'),
//               onPressed: () {
//                 final newStatus = TransactionStatus(
//                   id: status?.id ?? 0,
//                   statusName: statusName!,
//                   statusIndex: statusIndex!,
//                   transactionIndex: status?.transactionIndex ?? [],
//                 );
//                 onSave(newStatus);
//                 ref.read(navigationService).beamPop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class EditStatusDialog extends ConsumerStatefulWidget {
//   final TransactionStatus? status;
//   final Function(TransactionStatus) onSave;

//   const EditStatusDialog({Key? key, this.status, required this.onSave})
//       : super(key: key);

//   @override
//   _EditStatusDialogState createState() => _EditStatusDialogState();
// }

// class _EditStatusDialogState extends ConsumerState<EditStatusDialog> {
//   final _formKey = GlobalKey<FormState>();
//   late String _statusName;
//   late int _statusIndex;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title:
//           Text(widget.status != null ? 'Edytuj Status'.tr : 'Nowy Status'.tr),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               initialValue: _statusName,
//               decoration: InputDecoration(labelText: 'Nazwa Statusu'.tr),
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Wprowadź nazwę statusu'.tr
//                   : null,
//               onSaved: (value) => _statusName = value!,
//             ),
//             TextFormField(
//               initialValue: _statusIndex.toString(),
//               decoration: InputDecoration(labelText: 'Indeks Statusu'.tr),
//               keyboardType: TextInputType.number,
//               validator: (value) => value == null || int.tryParse(value) == null
//                   ? 'Wprowadź poprawny indeks'.tr
//                   : null,
//               onSaved: (value) => _statusIndex = int.parse(value!),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           child: Text('Anuluj'.tr),
//           onPressed: () => ref.read(navigationService).beamPop(),
//         ),
//         ElevatedButton(
//           child: Text('Zapisz'.tr),
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               _formKey.currentState!.save();
//               final newStatus = TransactionStatus(
//                 id: widget.status?.id ?? 0,
//                 statusName: _statusName,
//                 statusIndex: _statusIndex,
//                 transactionIndex: widget.status?.transactionIndex ?? [],
//               );
//               widget.onSave(newStatus);
//               ref.read(navigationService).beamPop();
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
