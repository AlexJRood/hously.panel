import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/modules/mail_view/components/editable_mail_button.dart';
import 'package:hously_flutter/modules/mail_view/utils/api_services.dart';


void showEmailOverlay(BuildContext context, WidgetRef ref, {int? leadId, Lead? lead}) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;
    final double screenSize = MediaQuery.of(context).size.width;
    final bool isMobile = screenSize < 800;



  entry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 20,
      right: isMobile ? 0 : 20,
      child: Material(
        elevation: 12,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? screenSize :  500),
          child: EmailSendOverlay(
            leadId: leadId,
            onClose: () => entry.remove(),
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);
}


class EmailSendOverlay extends ConsumerWidget {
  final int? leadId;
  final Lead? lead;
  final String? initialSubject;
  final String? initialBody;
  final String? initialEmail;
  final VoidCallback? onClose;

  const EmailSendOverlay({
    super.key,
    this.leadId,
    this.lead,
    this.initialSubject,
    this.initialBody,
    this.initialEmail,
    this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectController = TextEditingController(text: initialSubject);
    final bodyController = TextEditingController(text: initialBody);
    final emailController = TextEditingController(text: lead?.email ?? 'Dodaj maila');
    
    final double screenSize = MediaQuery.of(context).size.width;
    final bool isMobile = screenSize < 800;


    return Align(
      alignment: Alignment.bottomRight,
      child: Material(
        elevation: 12,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.circular(16)),
        color: Colors.white,
        child: Container(
          width: isMobile? screenSize : 500,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text('Nowa wiadomość', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onClose ?? () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Do: ', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(width: 8),
                  EditableEmailField(controller: emailController),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: subjectController,
                decoration: const InputDecoration(labelText: 'Temat'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bodyController,
                maxLines: 6,
                decoration: const InputDecoration(labelText: 'Treść'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onClose ?? () => Navigator.pop(context),
                    child: const Text('Anuluj'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final subject = subjectController.text.trim();
                      final body = bodyController.text.trim();
                      final email = emailController.text.trim();

                      if (subject.isEmpty || body.isEmpty || email.isEmpty) return;

                      try {
                        await EmailService.sendEmail(
                          ref: ref,
                          data: {
                            'subject': subject,
                            'body': body,
                            'recipients': [email],
                            if (leadId != null) 'lead': leadId,
                          },
                        );
                        onClose?.call();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Błąd: $e')),
                        );
                      }
                    },
                    child: const Text('Wyślij'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
