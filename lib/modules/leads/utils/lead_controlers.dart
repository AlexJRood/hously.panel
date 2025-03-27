import 'package:flutter/material.dart';

class LeadFormControllers {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final List<PhoneNumberController> phoneControllers = [PhoneNumberController()];
  final List<LeadEmailController> emailControllers = [LeadEmailController()];
  final List<InteractionController> interactionControllers = [InteractionController()];

  final AgreementController agreementController = AgreementController();
  final RegisterController registerController = RegisterController();
  final StatusController statusController = StatusController();

  void dispose() {
    idController.dispose();
    nameController.dispose();
    companyNameController.dispose();
    noteController.dispose();
    for (final c in phoneControllers) c.dispose();
    for (final c in emailControllers) c.dispose();
    for (final c in interactionControllers) c.dispose();
    agreementController.dispose();
    statusController.dispose();
  }
}

class PhoneNumberController {
  final TextEditingController number = TextEditingController();
  final TextEditingController label = TextEditingController();
  bool isPrimary = false;

  void dispose() {
    number.dispose();
    label.dispose();
  }
}

class LeadEmailController {
  final TextEditingController mailContent = TextEditingController();
  final TextEditingController mailSentDate = TextEditingController();
  final TextEditingController receiveMailContent = TextEditingController();
  final TextEditingController mailResponseDate = TextEditingController();
  bool isMailSent = false;
  bool isMailReceived = false;

  void dispose() {
    mailContent.dispose();
    mailSentDate.dispose();
    receiveMailContent.dispose();
    mailResponseDate.dispose();
  }
}

class InteractionController {
  final TextEditingController interactionType = TextEditingController();
  final TextEditingController content = TextEditingController();

  void dispose() {
    interactionType.dispose();
    content.dispose();
  }
}

class AgreementController {
  bool? hasAgreement;
  final TextEditingController agreementStatus = TextEditingController();
  bool? isMeetingScheduled;

  void dispose() {
    agreementStatus.dispose();
  }
}

class RegisterController {
  bool isRegister = false;
  final TextEditingController registerUser = TextEditingController();

  void dispose() {
    registerUser.dispose();
  }
}

class StatusController {
  final TextEditingController statusId = TextEditingController();
  final TextEditingController statusName = TextEditingController();
  final TextEditingController statusIndex = TextEditingController();

  void dispose() {
    statusId.dispose();
    statusName.dispose();
    statusIndex.dispose();
  }
}
