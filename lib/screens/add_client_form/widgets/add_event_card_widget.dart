import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/add_client_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/user_contact_custom_text_field.dart';
import 'dete_time_picker_widget.dart';

final showScheduleEventProvider = StateProvider<bool>(
      (ref) => false,
);

class AddEventCardWidget extends ConsumerWidget {
  final bool isMobile;
  const AddEventCardWidget(
      {super.key,
      this.isMobile = false
      });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final addClientForm = ref.watch(addClientFormProvider);
    final addClientFormNotifier = ref.read(addClientFormProvider.notifier);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 550,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(50, 50, 50, 1),
            borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Event',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 255, 255, 1)),
                ),
                IconButton(
                  icon: const Icon(
                  Icons.close,
                  color: Color.fromRGBO(200, 200, 200, 1),
                ),
                onPressed: () {
                  ref.read(showScheduleEventProvider.notifier).state = false;
                },
                )
              ],
            ),
            UserContactCustomTextField(
              id: 29,
              hintText: 'Add title',
              controller: addClientForm.eventTitleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Description be empty";
                }
                return null;
              },
              onChanged: (value) {
                addClientFormNotifier.updateTextField(
                  addClientForm.eventTitleController,
                  value,
                );
              },
            ),
             DateTimePickerWidget(
              isMobile:isMobile
            ),
            UserContactCustomTextField(
              id: 30,
              hintText: 'Add location',
              controller: addClientForm.eventLocationController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Description be empty";
                }
                return null;
              },
              onChanged: (value) {
                addClientFormNotifier.updateTextField(
                  addClientForm.eventLocationController,
                  value,
                );
              },
            ),
            UserContactCustomTextField(
              maxLines: 3,
              id: 31,
              hintText: 'Add notes',
              controller: addClientForm.eventDescriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Description be empty";
                }
                return null;
              },
              onChanged: (value) {
                addClientFormNotifier.updateTextField(
                  addClientForm.eventDescriptionController,
                  value,
                );
              },
            ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Reschedule',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 32,
                  width: 53,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(200, 200, 200, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text('Save',
                        style: TextStyle(
                          color: Color.fromRGBO(35, 35, 35, 1),
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
