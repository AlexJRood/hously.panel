import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/settings/api/mail_form.dart';
import 'package:hously_flutter/modules/settings/api/mail_services.dart';
import 'package:hously_flutter/modules/settings/provider/profile_provider.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/modules/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';



class EmailScreenPc extends ConsumerStatefulWidget {
  const EmailScreenPc({
    super.key,
  });

  @override
  ConsumerState<EmailScreenPc> createState() => _EmailScreenPcState();
}

bool _loading = true;

class _EmailScreenPcState extends ConsumerState<EmailScreenPc> {
  Future<bool> updateVariable() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.read(profileProvider.notifier);
    final theme = ref.watch(themeColorsProvider);
    final mailForm = ref.watch(emailAccountFormProvider);

    

    return FutureBuilder<bool>(
        future: updateVariable(),
        builder: (context, snapshot) {
          bool isLoaded = snapshot.data ?? false;
          if (!isLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                          HeadingText(text: 'Ustawienia skrzynki mailowej'),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: GradientTextField(
                                  controller: mailForm.imapHostController,
                                  hintText: 'IMAP Host',
                                  focusNode: mailForm.focusNodes[2],
                                  reqNode: mailForm.focusNodes[3],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GradientTextField(
                                  controller: mailForm.imapPortController,
                                  hintText: 'IMAP Port',
                                  keyboardType: TextInputType.number,
                                  focusNode: mailForm.focusNodes[0],
                                  reqNode: mailForm.focusNodes[1],
                                  
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: GradientTextField(
                                  controller: mailForm.smtpHostController,
                                  hintText: 'SMTP Host',
                                  focusNode: mailForm.focusNodes[4],
                                  reqNode: mailForm.focusNodes[5],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GradientTextField(
                                  controller: mailForm.smtpPortController,
                                  hintText: 'SMTP Port',
                                  keyboardType: TextInputType.number,
                                  focusNode: mailForm.focusNodes[6],
                                  reqNode: mailForm.focusNodes[7],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: GradientTextField(
                                  controller: mailForm.emailController,
                                  hintText: 'Adres e-mail',
                                  focusNode: mailForm.focusNodes[8],
                                  reqNode: mailForm.focusNodes[9],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GradientTextField(
                                  controller: mailForm.emailPasswordController,
                                  hintText: 'Hasło e-mail',
                                  focusNode: mailForm.focusNodes[10],
                                  reqNode: mailForm.focusNodes[1],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Settingsbutton(
                            isPc: true,
                            buttonheight: 40,
                            onTap: () async {
                              final data = {
                                "imap_host": mailForm.imapHostController.text,
                                "imap_port": int.tryParse(mailForm.imapPortController.text),
                                "smtp_host": mailForm.smtpHostController.text,
                                "smtp_port": int.tryParse(mailForm.smtpPortController.text),
                                "email_address": mailForm.emailController.text,
                                "email_password": mailForm.emailPasswordController.text,
                                "use_tls": true, // lub checkbox
                              };

                              await ref.read(emailAccountProvider.notifier).saveEmailAccount(data);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Zapisano ustawienia maila')),
                              );
                            },
                            text: 'Zapisz konto mailowe',
                          ),

                ],
              ),
            ),
          );
        });
  }
}
