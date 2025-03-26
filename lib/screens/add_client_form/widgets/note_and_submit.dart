import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/send_form_provider.dart';

class NoteAndSubmit extends ConsumerStatefulWidget {
  final VoidCallback onSubmit;
  final String selectedTab;
  final GlobalKey<FormState> viewFormKey;
  final GlobalKey<FormState> sellFormKey;
  final GlobalKey<FormState> buyFormKey;
  final bool isMobile;

  const NoteAndSubmit({
    super.key,
    required this.onSubmit,
    required this.selectedTab,
    required this.viewFormKey,
    required this.sellFormKey,
    required this.buyFormKey,
    required this.isMobile,
  });

  @override
  NoteAndSubmitState createState() => NoteAndSubmitState();
}

class NoteAndSubmitState extends ConsumerState<NoteAndSubmit> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final addClientForm = ref.watch(addClientFormProvider);

    return Column(
        children: [
          widget.isMobile
              ? SizedBox(
                  height: 400, // Maksymalna wysokość dla urządzeń mobilnych
                  child: _buildNoteContainer(addClientForm),
                )
              : Expanded(
                  child: _buildNoteContainer(addClientForm),
                ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              final String selectedTab = widget.selectedTab;

              final bool isViewFormValid = widget.viewFormKey.currentState?.validate() ?? false;
              final bool isSellFormValid = widget.sellFormKey.currentState?.validate() ?? false;
              final bool isBuyFormValid = widget.buyFormKey.currentState?.validate() ?? false;

              final VoidCallback submitAction = widget.onSubmit;

              if (selectedTab == 'VIEW' && isViewFormValid) {
                submitAction.call();
              } else if (selectedTab == 'SELL' && isSellFormValid && isViewFormValid) {
                submitAction.call();
              } else if (selectedTab == 'BUY' && isBuyFormValid && isViewFormValid) {
                submitAction.call();
              } else {
                print("❌ Form validation failed! Please fill in all required fields.");
              }
            },
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(200, 200, 200, 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: const Center(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Color.fromRGBO(35, 35, 35, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
    );
  }

  Widget _buildNoteContainer(AddClientFormState addClientForm) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(50, 50, 50, 1),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: TextField(
          controller: addClientForm.clientNoteController,
          focusNode: _focusNode,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.edit_calendar_rounded,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            fillColor: Color.fromRGBO(50, 50, 50, 1),
            hintText: 'Notes...',
            hintStyle: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 16,
            ),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          maxLines: null, // Dynamiczna wysokość
          minLines: 1,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}
