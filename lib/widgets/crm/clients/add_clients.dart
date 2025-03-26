import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/models/crm/user_contact_status_model.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/statuses_clients/contact_status_list.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class AddClientPopPc extends ConsumerStatefulWidget {
  const AddClientPopPc({super.key});

  @override
  SortPopPageState createState() => SortPopPageState();
}

class SortPopPageState extends ConsumerState<AddClientPopPc> {
  final _formKeyAddClientPopPc = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _clientTypeController;
  late TextEditingController _transactionTitleController;
  late TextEditingController _serviceTypeController;
  late TextEditingController _amountController;
  late TextEditingController _commissionController;
  late TextEditingController _newStatusController;

  int? selectedStatus;
  bool isAddingNewStatus = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _clientTypeController = TextEditingController();
    _transactionTitleController = TextEditingController();
    _serviceTypeController = TextEditingController();
    _amountController = TextEditingController();
    _commissionController = TextEditingController();
    _newStatusController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _clientTypeController.dispose();
    _transactionTitleController.dispose();
    _serviceTypeController.dispose();
    _amountController.dispose();
    _commissionController.dispose();
    _newStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final clientNotifier = ref.read(clientProvider.notifier);

    return Stack(
      children: [
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        GestureDetector(
          onTap: () {
            ref.read(navigationService).beamPop();
          },
        ),
        Hero(
          tag: 'addClientPagePop-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag 
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.5,
              height: screenHeight * 0.6,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient:  CustomBackgroundGradients.appBarGradientcustom(context, ref),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKeyAddClientPopPc,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: Textlebelfield(
                              label: 'Name',
                              badRequestLabel: 'Please enter a name',
                              controllerName: _nameController,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Textlebelfield(
                              label: 'Last name',
                              badRequestLabel: 'Please enter a last name',
                              controllerName: _lastNameController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Textlebelfield(
                        label: 'Email',
                        badRequestLabel: 'Please enter an email',
                        controllerName: _emailController,
                      ),
                      const SizedBox(height: 10),
                      Textlebelfield(
                        label: 'Phone Number',
                        badRequestLabel: 'Please enter a phone number',
                        controllerName: _phoneNumberController,
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
                                  decoration: const InputDecoration(labelText: 'Status'),
                                  value: selectedStatus,
                                  items: [
                                    ...statuses.map(( UserContactStatusModel status) {
                                      return DropdownMenuItem<int>(
                                        value: status.statusId,
                                        child: Text(status.statusName),
                                      );
                                    }).toList(),
                                    DropdownMenuItem(
                                      onTap: () { 
                                                              
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder: (_, __, ___) => UserContactStatusPopUp(isFilter: false),
                                              transitionsBuilder: (_, anim, __, child) {
                                                return FadeTransition(opacity: anim, child: child);
                                              },
                                            ),
                                          );
                                        },
                                      child: Text('Add new status'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                        selectedStatus = value;
                                  },
                                ),
                                if (isAddingNewStatus)
                                  TextFormField(
                                    controller: _newStatusController,
                                    decoration: const InputDecoration(
                                      labelText: 'New Status',
                                    ),
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
                      Textlebelfield(
                        label: 'Client Type',
                        badRequestLabel: 'Please enter a client type',
                        controllerName: _clientTypeController,
                      ),
                      const SizedBox(height: 10),
                      Textlebelfield(
                        label: 'Transaction Title',
                        badRequestLabel: 'Please enter a transaction title',
                        controllerName: _transactionTitleController,
                      ),
                      const SizedBox(height: 10),
                      Textlebelfield(
                        label: 'Service Type',
                        badRequestLabel: 'Please enter a service type',
                        controllerName: _serviceTypeController,
                      ),
                      const SizedBox(height: 10),
                      Textlebelfield(
                        label: 'Amount',
                        badRequestLabel: 'Please enter an amount',
                        controllerName: _amountController,
                      ),
                      const SizedBox(height: 10),
                      Textlebelfield(
                        label: 'Commission',
                        badRequestLabel: 'Please enter a commission',
                        controllerName: _commissionController,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKeyAddClientPopPc.currentState!.validate()) {
                            // Make sure we correctly capture the new status if added
                            final statusToUse = isAddingNewStatus
                                ? _newStatusController.text
                                : selectedStatus;
                            final client = UserContactModel(
                              id: 0,
                              name: _nameController.text,
                              lastName: _lastNameController.text,
                              email: _emailController.text,
                              phoneNumber: _phoneNumberController.text,
                              // favoriteLists: [], //change to production
                              // Add other fields here
                            );
                            clientNotifier.addClient(client);
                            ref.read(navigationService).beamPop();
                          }
                        },
                        child: const Text('Add Client'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Textlebelfield extends StatefulWidget {
  final TextEditingController controllerName;
  final String label;
  final String badRequestLabel;

  const Textlebelfield({
    Key? key,
    required this.label,
    required this.badRequestLabel,
    required this.controllerName,
  }) : super(key: key);

  @override
  _TextlebelfieldState createState() => _TextlebelfieldState();
}

class _TextlebelfieldState extends State<Textlebelfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controllerName,
      style: AppTextStyles.interMedium16,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppTextStyles.interMedium14_50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      selectionHeightStyle: ui.BoxHeightStyle.tight,
      // obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.badRequestLabel;
        }
        return null;
      },
    );
  }
}
