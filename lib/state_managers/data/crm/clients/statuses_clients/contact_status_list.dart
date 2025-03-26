// edit_status_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/models/crm/user_contact_status_model.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/statuses_clients/client_statuses_state.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'dart:ui' as ui;


final editingStatusProvider = StateProvider<int?>((ref) => null);
final addingStatusProvider = StateProvider<bool>((ref) => false); // Nowy status
final addStatusFocusNodeProvider = Provider((ref) => FocusNode()); // FocusNode dla pola dodawania


class UserContactStatusPopUp extends ConsumerWidget {
  UserContactModel? contact;
  bool isFilter;
  UserContactStatusPopUp({super.key, this.contact, required this.isFilter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Efekt rozmycia tła
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Warstwa obsługująca zamknięcie modalu po kliknięciu w tło
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent, // Przezroczyste tło, żeby było klikalne
            ),
          ),

          // Modal z zawartością
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.2 - 45,
                top: screenHeight * 0.05,
              ),
              child: Hero(
                tag: 'StatusPopUserContactList',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: SizedBox(
                      width: screenWidth * 0.2 <= 500 ? 450 : 450,
                      height: screenHeight * 0.8,
                      child: UserContactStatusDialog(contact: contact, isFilter: isFilter,),
                              ),
                                ),
                ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}











class UserContactStatusDialog extends ConsumerWidget{
  final UserContactModel? contact;
  bool isFilter;
  UserContactStatusDialog({super.key, required this.contact, required this.isFilter});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final statusState = ref.watch(userContactsProvider);

    return Expanded(
      child: statusState.when(
        data: (userContactState) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              if(isFilter)
              ...[
                Text(
                  'Filtruj statusy',
                  style: AppTextStyles.interMedium14,
                ),

                
              ]
              else
              ...[
                Text(
                  'Zmień Status kontaktu',
                  style: AppTextStyles.interMedium14,
                ),
              ],


Expanded(
  child: GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      // Gdy użytkownik kliknie poza polem, schowaj pole dodawania
      FocusScope.of(context).unfocus();
      ref.read(addingStatusProvider.notifier).state = false;
      ref.read(editingStatusProvider.notifier).state = null;
    },
    child: ReorderableListView.builder(
      itemCount: userContactState.contactStatuses.length + 1, // +1 dla przycisku dodawania
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex -= 1;
        _onReorder(ref, userContactState, oldIndex, newIndex);
      },
      buildDefaultDragHandles: false, // Usuwa domyślną ikonę przeciągania
      itemBuilder: (context, index) {
        if (index == userContactState.contactStatuses.length) {
          // Ostatni element - pole do dodawania nowego statusu
          final isAdding = ref.watch(addingStatusProvider);
          final focusNode = ref.watch(addStatusFocusNodeProvider);


          

          return KeyedSubtree(
            key: const ValueKey('add_button'), // Unikalny key dla przycisku
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
              child: isAdding
                  ? TextField(
                      key: const ValueKey('add_status_field'), // Klucz dla pola tekstowego
                      autofocus: true,
                      focusNode: focusNode, // Przypisujemy FocusNode
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        hintText: 'Wpisz nowy status...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      onSubmitted: (newValue) {
                        if (newValue.isNotEmpty) {
                          final newStatus = UserContactStatusModel(
                            statusId: DateTime.now().millisecondsSinceEpoch, // Tymczasowy unikalny ID
                            statusName: newValue,
                            statusIndex: userContactState.contactStatuses.length,
                            contactIndex: [],
                          );
                          ref.read(userContactsProvider.notifier).createUserContactStatus(newStatus, ref);
                        }
                        ref.read(addingStatusProvider.notifier).state = false; // Ukryj pole po dodaniu
                      },
                      onEditingComplete: () {
                        ref.read(addingStatusProvider.notifier).state = false; // Ukryj pole po kliknięciu poza nim
                      },
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: elevatedButtonStyleRounded10,
                        onPressed: () {
                          ref.read(addingStatusProvider.notifier).state = true;
                          Future.delayed(Duration(milliseconds: 100), () {
                            focusNode.requestFocus(); // Automatyczne ustawienie focusa
                          });
                        },
                        child: const Icon(Icons.add, color: AppColors.backgroundColor),
                      ),
                    ),
            ),
          );
        }

                    final status = userContactState.contactStatuses[index];
              
                    return KeyedSubtree(
                      key: ValueKey(status.statusId),
                      child: DragTarget<int>(
                        onWillAccept: (data) => true,
                        onAccept: (data) {},
                        builder: (context, candidateData, rejectedData) {
                          final isBeingDragged = candidateData.isNotEmpty;
                          final isEditing = ref.watch(editingStatusProvider) == status.statusId;

                          return ReorderableDragStartListener(
                            index: index,
                            child: Container(
                              color: isBeingDragged ? Colors.grey[300] : Colors.transparent, // Zmiana koloru przy przeciąganiu
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: isEditing
                                  ? TextField(
                                          autofocus: true,
                                          controller: TextEditingController(text: status.statusName)
                                            ..selection = TextSelection.fromPosition(
                                              TextPosition(offset: status.statusName.length),
                                            ),
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          ),
                                          onSubmitted: (newValue) {
                                            if (newValue.isNotEmpty) {
                                              final updatedStatus = UserContactStatusModel(
                                                statusId: status.statusId,
                                                statusName: newValue,
                                                statusIndex: status.statusIndex,
                                                contactIndex: status.contactIndex,
                                              );
                                              ref.read(userContactsProvider.notifier).updateUserContactStatus(updatedStatus, ref);
                                            }
                                            ref.read(editingStatusProvider.notifier).state = null; // Wyłącz edycję
                                          },
                                        ) 
                                  : ListTile(
                                        title: Text(
                                          status.statusName,
                                          style: AppTextStyles.interMedium14,
                                        ),
                                        onTap: () {
                                            FocusScope.of(context).unfocus();
                                            ref.read(addingStatusProvider.notifier).state = false;
                                          if(isFilter){ 
                                            ref.read(clientProvider.notifier).fetchClients(status: status.statusId);
                                            Navigator.of(context).pop();         
                                          }else if (contact != null) {
                                            ref.read(userContactsProvider.notifier).updateUserContactStatusById(contact!, status, ref);
                                            Navigator.of(context).pop();                                        
                                          }
                                        },
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              style: elevatedButtonStyleRounded10,
                                              icon: const Icon(Icons.edit, color: AppColors.light),
                                                      onPressed: () {
                                                      FocusScope.of(context).unfocus();
                                                      ref.read(addingStatusProvider.notifier).state = false;
                                                      ref.read(editingStatusProvider.notifier).state = status.statusId; // Włącza edycję
                                                    },
                                            ),
                                            const SizedBox(width: 10),
                                            IconButton(
                                              style: elevatedButtonStyleRounded10,
                                              icon: const Icon(Icons.delete, color: AppColors.light),
                                              onPressed: () {
                                                FocusScope.of(context).unfocus();
                                                ref.read(addingStatusProvider.notifier).state = false;
                                               _deleteStatus(ref, status.statusId);
                                               }
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }


  void _onReorder(WidgetRef ref, UserContactState userContactState, int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final movedStatus = userContactState.contactStatuses.removeAt(oldIndex);
    userContactState.contactStatuses.insert(newIndex, movedStatus);

    final updatedStatuses = userContactState.contactStatuses.asMap().entries.map((entry) {
      final index = entry.key;
      final status = entry.value;
      return UserContactStatusModel(
        statusId: status.statusId,
        statusName: status.statusName,
        statusIndex: index, 
        contactIndex: status.contactIndex,
      );
    }).toList();
    ref.read(userContactsProvider.notifier).reorderStatuses(updatedStatuses);
  }


  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => EditStatusDialog(
        onSave: (newStatus) {
          ref.read(userContactsProvider.notifier).createUserContactStatus(newStatus,ref);
        },
      ),
    );
  }

  void _deleteStatus(WidgetRef ref, int id) {
    ref.read(userContactsProvider.notifier).deleteuserContactStatus(id,ref);
  }
}


class EditStatusDialog extends ConsumerStatefulWidget {
  final UserContactStatusModel? status;
  final Function(UserContactStatusModel) onSave;

  const EditStatusDialog({super.key, this.status, required this.onSave});

  @override
  _EditStatusDialogState createState() => _EditStatusDialogState();
}

class _EditStatusDialogState extends ConsumerState<EditStatusDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _statusName;
  late int _statusIndex;

  @override
  void initState() {
    super.initState();
    _statusName = widget.status?.statusName ?? '';
    _statusIndex = widget.status?.statusIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.status != null ? 'Edytuj Status'.tr : 'Nowy Status'.tr),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _statusName,
              decoration:  InputDecoration(labelText: 'Nazwa Statusu'.tr),
              validator: (value) => value == null || value.isEmpty
                  ? 'Wprowadź nazwę statusu'.tr
                  : null,
              onSaved: (value) => _statusName = value!,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child:  Text('Anuluj'.tr),
          onPressed: () => ref.read(navigationService).beamPop(),
        ),
        ElevatedButton(
          child:  Text('Zapisz'.tr),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newStatus = UserContactStatusModel(
                statusId: widget.status?.statusId ?? 0,
                statusName: _statusName,
                statusIndex: _statusIndex,
                contactIndex: widget.status?.contactIndex ?? [],
              );
              widget.onSave(newStatus);
              Navigator.of(context).pop();  
            }
          },
        ),
      ],
    );
  }
}
