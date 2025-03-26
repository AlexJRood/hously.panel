import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/add_client_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/note_and_submit.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/user_contacts_widget.dart';

import 'add_client_form_pc.dart';

class AddClientFormMobile extends ConsumerStatefulWidget {
  const AddClientFormMobile({super.key});

  @override
  ConsumerState<AddClientFormMobile> createState() =>
      _AddClientFormMobileState();
}

class _AddClientFormMobileState extends ConsumerState<AddClientFormMobile> {
  final _viewFormKey = GlobalKey<FormState>();
  final _sellFormKey = GlobalKey<FormState>();
  final _buyFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(selectedTabProvider);
    final addClientProvider = ref.read(addClientFormProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(selectedTabProvider.notifier).state = 'VIEW';
                    },
                    child: Text(
                      'VIEW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: selectedTab == 'VIEW' ? 18 : 16,
                        fontWeight: selectedTab == 'VIEW'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      ref.read(selectedTabProvider.notifier).state = 'SELL';
                    },
                    child: Text(
                      'SELL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: selectedTab == 'SELL' ? 18 : 16,
                        fontWeight: selectedTab == 'SELL'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      ref.read(selectedTabProvider.notifier).state = 'BUY';
                    },
                    child: Text(
                      'BUY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: selectedTab == 'BUY' ? 18 : 16,
                        fontWeight: selectedTab == 'BUY'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'Create a new user profile',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter client information and personalize their profile',
                style: TextStyle(
                  color: Color.fromRGBO(200, 200, 200, 1),
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                              color: Color.fromRGBO(233, 233, 233, 1),
                              fontSize: 14,
                            ),
                            focusColor: const Color.fromRGBO(35, 35, 35, 1),
                            fillColor: const Color.fromRGBO(35, 35, 35, 1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(35, 35, 35, 1))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(35, 35, 35, 1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(35, 35, 35, 1)))),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      ref.read(showUserContactsProvider.notifier).state = true;
                    },
                    child: Container(
                      width: 99,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(200, 200, 200, 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Color.fromRGBO(35, 35, 35, 1),
                          ),
                          Text(
                            'New user',
                            style: TextStyle(
                                color: Color.fromRGBO(35, 35, 35, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserContactsWidget(
                    viewFormKey: _viewFormKey,
                    sellFormKey: _sellFormKey,
                    buyFormKey: _buyFormKey,
                    isMobile: true,
                  ),
                  NoteAndSubmit(
                    selectedTab: selectedTab,
                    viewFormKey: _viewFormKey,
                    sellFormKey: _sellFormKey,
                    buyFormKey: _buyFormKey,
                    onSubmit: () async {
                      if (selectedTab == 'VIEW') {
                        addClientProvider
                            .estateViewing()
                            .whenComplete(() {
                              // addClientProvider.clearForm();
                            },);
                      } else if (selectedTab == 'SELL') {
                        addClientProvider
                            .sellTransAction()
                            .whenComplete(() {
                              // addClientProvider.clearForm();
                            },);
                      } else if (selectedTab == 'BUY') {
                        addClientProvider
                            .buyTransAction()
                            .whenComplete(() {
                          // addClientProvider.clearForm();
                        },);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
