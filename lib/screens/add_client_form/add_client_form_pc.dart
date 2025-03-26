import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/components/usercontact/contact_list.dart';
import 'package:hously_flutter/screens/add_client_form/provider/send_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/get_selected_widget.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/note_and_submit.dart';
import 'package:hously_flutter/screens/add_client_form/components/usercontact/add_user_contacts.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

final showUserContactsProvider = StateProvider<bool>(
  (ref) => false,
);

class AddClientFormPc extends ConsumerStatefulWidget {
  const AddClientFormPc({super.key});

  @override
  ConsumerState<AddClientFormPc> createState() => _AddClientFormState();
}

class _AddClientFormState extends ConsumerState<AddClientFormPc> {
  final _viewFormKey = GlobalKey<FormState>();
  final _sellFormKey = GlobalKey<FormState>();
  final _buyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(selectedTabProvider);
    final addClientProvider = ref.read(addClientFormProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.85),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Obsługa dotknięcia w dowolnym miejscu aby zamknąć modal
          GestureDetector(
            onTap: () => ref.read(navigationService).beamPop(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(selectedTabProvider.notifier).state =
                                    'VIEW';
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
                                ref.read(selectedTabProvider.notifier).state =
                                    'SELL';
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
                                ref.read(selectedTabProvider.notifier).state =
                                    'BUY';
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
                        
                        
                        if (!ref.watch(showUserContactsProvider)) 
                          ...[
                              const ClientListAddFormCrm(),
                          ] else 
                          ...  [
                            
                              Row(
                                spacing: 30,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: AddUserContactsCrm(
                                    viewFormKey: _viewFormKey,
                                    sellFormKey: _sellFormKey,
                                    buyFormKey: _buyFormKey,
                                  )),
                                ],
                              ),
                          ],
                          
                        const SizedBox(height: 20),
                        GetSelectedWidget(
                          sellFormKey: _sellFormKey,
                          buyFormKey: _buyFormKey,
                          isMobile: false,
                        ),
                          
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                Expanded(
                  flex: 1,
                  child: NoteAndSubmit(
                    selectedTab: selectedTab,
                    viewFormKey: _viewFormKey,
                    sellFormKey: _sellFormKey,
                    buyFormKey: _buyFormKey,
                    isMobile: false,
                    onSubmit: () async {
                      if (selectedTab == 'VIEW') {
                        addClientProvider.estateViewing().whenComplete(
                          () {
                            addClientProvider.clearForm();
                          },
                        );
                      } else if (selectedTab == 'SELL') {
                        addClientProvider.sellTransAction(ref).whenComplete(
                          () {
                            addClientProvider.clearForm();
                          },
                        );
                      } else if (selectedTab == 'BUY') {
                        addClientProvider.buyTransAction(ref).whenComplete(
                          () {
                            addClientProvider.clearForm();
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
