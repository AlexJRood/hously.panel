import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/models/crm/user_contact_status_model.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';

class AddClientForm extends ConsumerStatefulWidget {
  const AddClientForm({super.key});

  @override
  AddClientFormState createState() => AddClientFormState();
}

class AddClientFormState extends ConsumerState<AddClientForm> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _clientTypeController;
  // late TextEditingController _transactionTitleController;
  late TextEditingController _serviceTypeController;
  // late TextEditingController _amountController;
  // late TextEditingController _commissionController;
  late TextEditingController _newStatusController;

  String? selectedClient;
  bool isAddingNewStatus = false;
  bool isOpen = false;
  int? selectedStatus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _clientTypeController = TextEditingController();
    // _transactionTitleController = TextEditingController();
    _serviceTypeController = TextEditingController();
    // _amountController = TextEditingController();
    // _commissionController = TextEditingController();
    _newStatusController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _clientTypeController.dispose();
    // _transactionTitleController.dispose();
    _serviceTypeController.dispose();
    // _amountController.dispose();
    // _commissionController.dispose();
    _newStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientNotifier = ref.read(clientProvider.notifier);

    return Container(
      width: double.infinity,
      height: isOpen ? 450 : 75,
      child: Column(
        children: [
          if (isOpen)
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Form(
                  // key: _formKeyClient, // Unique GlobalKey for the form
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: ClientTextFormField(
                                labelText: 'Name',
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: ClientTextFormField(
                                labelText: 'Last name',
                                controller: _lastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClientTextFormField(
                          labelText: 'Email',
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        ClientTextFormField(
                          labelText: 'Phone Number',
                          controller: _phoneNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder<List<UserContactStatusModel>>(
                          future: clientNotifier.fetchStatuses(ref),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('No statuses available');
                            } else {
                              final statuses = snapshot.data!;
                              return Column(
                                children: [
                                  DropdownButtonFormField<int>(
                                    decoration: InputDecoration(
                                        labelText: 'Status',
                                        labelStyle: AppTextStyles.interRegular14),
                                    value: selectedStatus,
                                    items: [
                                      ...statuses.map((UserContactStatusModel status) {
                                        return DropdownMenuItem<int>(
                                          value: status.statusId,
                                          child: Text(status.statusName,
                                              style: AppTextStyles.interRegular14),
                                        );
                                      }).toList(),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                          selectedStatus = value;
                                      });
                                    },
                                  ),
                                  if (isAddingNewStatus)
                                    ClientTextFormField(
                                      labelText: 'New Status',
                                      controller: _newStatusController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a new status';
                                        }
                                        return null;
                                      },
                                    ),
                                ],
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        ClientTextFormField(
                          labelText: 'Client Type',
                          controller: _clientTypeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a client type';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 10),
                        // ClientTextFormField(
                        //   labelText: 'Transaction Title',
                        //   controller: _transactionTitleController,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter a transaction title';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        const SizedBox(height: 10),
                        ClientTextFormField(
                          labelText: 'Service Type',
                          controller: _serviceTypeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a service type';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 10),
                        // ClientTextFormField(
                        //   labelText: 'Amount',
                        //   controller: _amountController,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter an amount';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // const SizedBox(height: 10),
                        // ClientTextFormField(
                        //   labelText: 'Commission',
                        //   controller: _commissionController,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter a commission';
                        //     }
                        //     return null;
                        //   },
                        // ),const SizedBox(height: 10,),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isOpen = !isOpen;
                            });
                          },
                          child: isOpen
                              ? const Icon(Icons.remove)
                              : const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: FutureBuilder<List<UserContactModel>>(
                    future: ref.read(clientProvider.notifier).fetchClientsList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No clients available');
                      } else {
                        final clients = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedClient,
                            decoration: InputDecoration(
                                labelText: 'Client',
                                labelStyle: AppTextStyles.interRegular14),
                            items: clients.map((client) {
                              return DropdownMenuItem<String>(
                                value: client.id.toString(),
                                child: Text('${client.name} ${client.lastName}',
                                    style: AppTextStyles.interRegular14dark),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedClient = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a client';
                              }
                              return null;
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                  child:
                      isOpen ? const Icon(Icons.remove) : const Icon(Icons.add),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Map<String, dynamic>? _parseJson(String jsonString) {
    if (jsonString.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  List<dynamic>? _parseJsonList(String jsonString) {
    if (jsonString.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(jsonString) as List<dynamic>;
    } catch (e) {
      return null;
    }
  }
}

class ClientTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const ClientTextFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText, labelStyle: AppTextStyles.interRegular14),
      controller: controller,
      validator: validator,
    );
  }
}
