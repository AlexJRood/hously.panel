import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/screens/add_client_form/add_client_form_pc.dart';
import 'package:hously_flutter/screens/add_client_form/provider/send_form_provider.dart';

import 'package:hously_flutter/screens/add_client_form/components/usercontact/user_contact_custom_text_field.dart';
import 'package:hously_flutter/screens/add_client_form/components/usercontact/usercontact_custom_drop_down.dart';

class AddUserContactsCrm extends ConsumerWidget {
  final GlobalKey<FormState> viewFormKey;
  final GlobalKey<FormState> sellFormKey;
  final GlobalKey<FormState> buyFormKey;
  final bool isMobile;

  const AddUserContactsCrm({
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
    final selectedClientId = addClientForm.selectedClientId;

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
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(35, 35, 35, 1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          topLeft: Radius.circular(6))),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'USER CONTACTS',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width:50, height: 50,
                          child: ElevatedButton(
                            style: elevatedButtonStyleRounded10,
                            onPressed: (){
                                  ref.read(showUserContactsProvider.notifier)
                                      .state = false;
                            },
                            child: const Icon(
                              Icons.expand_more,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
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
                          valueKey: 'name',
                          hintText: 'First Name',
                          controller: addClientForm.clientNameController,
                          validator: (value) {
                            if (selectedClientId != null) {
                              return null; // pomijamy walidację
                            }
                            if (value == null || value.isEmpty) {
                              return "First Name cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (valueKey, value) {
                            addClientFormNotifier.updateTextField(
                              addClientForm.clientNameController,
                              value,
                            );
                          },
                        ),
                        UserContactCustomTextField(
                          id: 2,
                          valueKey: 'last_name',
                          hintText: 'Last Name',
                          controller: addClientForm.clientEmailController,
                          validator: (value) {
                            if (selectedClientId != null) {
                              return null; // pomijamy walidację
                            }
                            if (value == null || value.isEmpty) {
                              return "Last Name cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (valueKey, value) {
                            addClientFormNotifier.updateTextField(
                              addClientForm.clientEmailController,
                              value,
                            );
                          },
                        ),
                        UserContactCustomTextField(
                          id: 3,
                          valueKey: 'email',
                          hintText: 'Email',
                          controller: addClientForm.clientEmailController,
                          validator: (value) {
                            if (selectedClientId != null) {
                              return null; // pomijamy walidację
                            }
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                          onChanged: (valueKey, value) {
                            addClientFormNotifier.updateTextField(
                              addClientForm.clientEmailController,
                              value,
                            );
                          },
                        ),
                        UserContactCustomTextField(
                          id: 4,
                          valueKey: 'phone_number',
                          hintText: 'Phone Number',
                          controller:
                          addClientForm.clientPhoneNumberController,
                          validator: (value) {
                            if (selectedClientId != null) {
                              return null; // pomijamy walidację
                            }
                            if (value == null || value.isEmpty) {
                              return "Phone Number cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (valueKey, value) {
                            addClientFormNotifier.updateTextField(
                              addClientForm.clientPhoneNumberController,
                              value,
                            );
                          },
                        ),
                        const AddClientFormCustomDropDown(
                          options: ['option 1', 'option 2', 'option 3'],
                          hintText: 'Service Type',
                          valueKey: 'phone_number',
                          id: 4,
                        ),
                        const AddClientFormCustomDropDown(
                          options: ['option 1', 'option 2', 'option 3'],
                          hintText: 'contact_type',
                          valueKey: 'contact_status',
                          id: 9,
                        ),
                        const AddClientFormCustomDropDown(
                          options: ['option 1', 'option 2', 'option 3'],
                          hintText: 'Contact type',
                          valueKey: 'contact_type',
                          id: 1,
                        ),
                        const AddClientFormCustomDropDown(
                          options: ['option 1', 'option 2', 'option 3'],
                          hintText: 'Responsible person',
                          valueKey: 'responsible_person',
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
                                hintText: 'name',
                                valueKey: 'contact_type',
                                controller:
                                addClientForm.clientNameController,
                                validator: (value) {
                                  if (selectedClientId != null) {
                                    return null; // pomijamy walidację
                                  }
                                  if (value == null || value.isEmpty) {
                                    return "First Name cannot be empty";
                                  }
                                  return null;
                                },
                                onChanged: (valueKey, value) {
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
                                valueKey: 'contact_type',
                                hintText: 'last_name',
                                controller: addClientForm
                                    .clientLastNameController,
                                validator: (value) {
                                  if (selectedClientId != null) {
                                    return null; // pomijamy walidację
                                  }
                                  if (value == null || value.isEmpty) {
                                    return "Last Name cannot be empty";
                                  }
                                  return null;
                                },
                                onChanged: (valueKey, value) {
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
                                valueKey: 'email',
                                hintText: 'Email',
                                controller:
                                addClientForm.clientEmailController,
                                validator: (value) {
                                  if (selectedClientId != null) {
                                    return null; // pomijamy walidację
                                  }
                                  if (value == null || value.isEmpty) {
                                    return "Email cannot be empty";
                                  } else if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                      .hasMatch(value)) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                                onChanged: (valueKey, value) {
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
                                  valueKey: 'phone_number',
                                  hintText: 'Phone Number',
                                  controller: addClientForm
                                      .clientPhoneNumberController,
                                  validator: (value) {                                    
                                    if (selectedClientId != null) {
                                      return null; // pomijamy walidację
                                    }
                                    if (value == null || value.isEmpty) {
                                      return "Phone Number cannot be empty";
                                    }
                                    return null;
                                  },
                                  onChanged: (valueKey, value) {
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
                                  valueKey: 'service_type',
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
                                  valueKey: 'contact_status',
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
                                  valueKey: 'contact_type',
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
                                  valueKey: 'responsible_person',
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
      ],
    );
  }
}

