import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/add_client_form_pc.dart';
import 'package:hously_flutter/screens/add_client_form/provider/add_client_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/get_selected_widget.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/user_contact_custom_text_field.dart';
import 'add_client_form_custom_drop_down.dart';

class UserContactsWidget extends ConsumerWidget {
  final GlobalKey<FormState> viewFormKey;
  final GlobalKey<FormState> sellFormKey;
  final GlobalKey<FormState> buyFormKey;
  final bool isMobile;

  const UserContactsWidget({
    super.key,
    required this.viewFormKey,
    required this.sellFormKey,
    required this.buyFormKey,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addClientForm = ref.watch(addClientFormProvider);
    final addClientFormNotifier = ref.read(addClientFormProvider.notifier);
    return Column(
      spacing: 20,
      children: [
        if (ref.watch(showUserContactsProvider))
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(50, 50, 50, 1),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Column(
              children: [
                Container(
                  height: 48,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(35, 35, 35, 1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          topLeft: Radius.circular(6))),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'USER CONTACTS',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        Icon(
                          Icons.expand_more,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: viewFormKey,
                    child: isMobile
                        ? Column(
                      spacing: 12,
                      children: [
                        UserContactCustomTextField(
                          id: 1,
                          hintText: 'First Name',
                          controller: addClientForm.clientNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "First Name cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            addClientFormNotifier.updateTextField(
                              addClientForm.clientNameController,
                              value,
                            );
                          },
                        ),
                        UserContactCustomTextField(
                          id: 2,
                          hintText: 'Last Name',
                          controller: addClientForm.clientEmailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Last Name cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            addClientFormNotifier.updateTextField(
                              addClientForm.clientEmailController,
                              value,
                            );
                          },
                        ),
                        UserContactCustomTextField(
                          id: 3,
                          hintText: 'Email',
                          controller: addClientForm.clientEmailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            addClientFormNotifier.updateTextField(
                              addClientForm.clientEmailController,
                              value,
                            );
                          },
                        ),
                        UserContactCustomTextField(
                          id: 4,
                          hintText: 'Phone Number',
                          controller:
                          addClientForm.clientPhoneNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone Number cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            addClientFormNotifier.updateTextField(
                              addClientForm.clientPhoneNumberController,
                              value,
                            );
                          },
                        ),
                        const AddClientFormCustomDropDown(
                          options: ['option 1', 'option 2', 'option 3'],
                          hintText: 'Service Type',
                          id: 4,
                        ),
                        const AddClientFormCustomDropDown(
                          options: ['option 1', 'option 2', 'option 3'],
                          hintText: 'Contact status',
                          id: 9,
                        ),
                        const AddClientFormCustomDropDown(
                          options: ['option 1', 'option 2', 'option 3'],
                          hintText: 'Contact type',
                          id: 1,
                        ),
                        const AddClientFormCustomDropDown(
                          options: ['option 1', 'option 2', 'option 3'],
                          hintText: 'Created by',
                          id: 2,
                        ),
                        const AddClientFormCustomDropDown(
                          options: ['option 1', 'option 2', 'option 3'],
                          hintText: 'Responsible person',
                          id: 3,
                        ),
                      ],
                    )
                        : Column(
                      spacing: 12,
                      children: [
                        Row(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: UserContactCustomTextField(
                                id: 1,
                                hintText: 'First Name',
                                controller:
                                addClientForm.clientNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "First Name cannot be empty";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  addClientFormNotifier.updateTextField(
                                    addClientForm.clientNameController,
                                    value,
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: UserContactCustomTextField(
                                id: 2,
                                hintText: 'Last Name',
                                controller: addClientForm
                                    .clientLastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Last Name cannot be empty";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  addClientFormNotifier.updateTextField(
                                    addClientForm.clientLastNameController,
                                    value,
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: UserContactCustomTextField(
                                id: 3,
                                hintText: 'Email',
                                controller:
                                addClientForm.clientEmailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email cannot be empty";
                                  } else if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                      .hasMatch(value)) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  addClientFormNotifier.updateTextField(
                                    addClientForm.clientEmailController,
                                    value,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 12,
                          children: [
                            Expanded(
                                child: UserContactCustomTextField(
                                  id: 4,
                                  hintText: 'Phone Number',
                                  controller: addClientForm
                                      .clientPhoneNumberController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Phone Number cannot be empty";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    addClientFormNotifier.updateTextField(
                                      addClientForm.clientPhoneNumberController,
                                      value,
                                    );
                                  },
                                )),
                            const Expanded(
                                child: AddClientFormCustomDropDown(
                                  options: [
                                    'option 1',
                                    'option 2',
                                    'option 3'
                                  ],
                                  hintText: 'Service Type',
                                  id: 4,
                                )),
                            const Expanded(
                                child: AddClientFormCustomDropDown(
                                  options: [
                                    'option 1',
                                    'option 2',
                                    'option 3'
                                  ],
                                  hintText: 'Contact status',
                                  id: 9,
                                )),
                          ],
                        ),
                        const Row(
                          spacing: 12,
                          children: [
                            Expanded(
                                child: AddClientFormCustomDropDown(
                                  options: [
                                    'option 1',
                                    'option 2',
                                    'option 3'
                                  ],
                                  hintText: 'Contact type',
                                  id: 1,
                                )),
                            Expanded(
                                child: AddClientFormCustomDropDown(
                                  options: [
                                    'option 1',
                                    'option 2',
                                    'option 3'
                                  ],
                                  hintText: 'Created by',
                                  id: 2,
                                )),
                            Expanded(
                                child: AddClientFormCustomDropDown(
                                  options: [
                                    'option 1',
                                    'option 2',
                                    'option 3'
                                  ],
                                  hintText: 'Responsible person',
                                  id: 3,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        GetSelectedWidget(
          sellFormKey: sellFormKey,
          buyFormKey: buyFormKey,
          isMobile: isMobile,
        ),
      ],
    );
  }
}