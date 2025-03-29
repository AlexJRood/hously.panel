import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

class EmailAccountForm extends ChangeNotifier {
  final imapHostController = TextEditingController();
  final imapPortController = TextEditingController();
  final smtpHostController = TextEditingController();
  final smtpPortController = TextEditingController();
  final emailController = TextEditingController();
  final emailPasswordController = TextEditingController();


final List<FocusNode> focusNodes = List.generate(12, (_) => FocusNode());

  void disposeAll() {
    imapHostController.dispose();
    imapPortController.dispose();
    smtpHostController.dispose();
    smtpPortController.dispose();
    emailController.dispose();
    emailPasswordController.dispose();
  }
}

final emailAccountFormProvider = Provider<EmailAccountForm>((ref) {
  final form = EmailAccountForm();
  ref.onDispose(form.disposeAll);
  return form;
});
