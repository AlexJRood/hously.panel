import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordNotifier() : super(ForgotPasswordState());

  void setEmailController(TextEditingController controller) {
    state = state.copyWith(emailController: controller);
  }

  void setEmailFocusNode(FocusNode focusNode) {
    state = state.copyWith(emailFocusNode: focusNode);
  }

  void startTimer() {
    state.timer?.cancel();
    state = state.copyWith(
      remainingSeconds: 0,
      progressValue: 0.0,
      timer: Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.remainingSeconds < state.initialSeconds) {
          state = state.copyWith(
            remainingSeconds: state.remainingSeconds + 1,
            progressValue: (state.remainingSeconds + 1) / state.initialSeconds,
          );
        } else {
          timer.cancel();
        }
      }),
    );
  }

  void sendResetLink() {
    if (state.formKey.currentState?.validate() ?? false) {
      state = state.copyWith(
        isLinkSent: true,
        remainingSeconds: 0,
        progressValue: 0.0,
      );
      startTimer();
    }
  }

  void resetLinkState() {
    state.timer?.cancel();
    state = state.copyWith(
        isLinkSent: false, remainingSeconds: 0, progressValue: 0.0);
  }

  @override
  void dispose() {
    state.emailController.dispose();
    state.emailFocusNode.dispose();
    state.timer?.cancel();
    super.dispose();
  }
}

class ForgotPasswordState {
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final bool isLinkSent;
  final int remainingSeconds;
  final int initialSeconds;
  final double progressValue;
  final Timer? timer;
  final GlobalKey<FormState> formKey;

  ForgotPasswordState({
    TextEditingController? emailController,
    FocusNode? emailFocusNode,
    GlobalKey<FormState>? formKey,
    this.isLinkSent = false,
    this.remainingSeconds = 0,
    this.initialSeconds = 60,
    this.progressValue = 0.0,
    this.timer,
  })  : emailController = emailController ?? TextEditingController(),
        emailFocusNode = emailFocusNode ?? FocusNode(),
        formKey = formKey ?? GlobalKey<FormState>(); // Fixed initialization

  ForgotPasswordState copyWith({
    TextEditingController? emailController,
    FocusNode? emailFocusNode,
    GlobalKey<FormState>? formKey,
    bool? isLinkSent,
    int? remainingSeconds,
    int? initialSeconds,
    double? progressValue,
    Timer? timer,
  }) {
    return ForgotPasswordState(
      emailController: emailController ?? this.emailController,
      emailFocusNode: emailFocusNode ?? this.emailFocusNode,
      formKey: formKey ?? this.formKey, // Added formKey
      isLinkSent: isLinkSent ?? this.isLinkSent,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      initialSeconds: initialSeconds ?? this.initialSeconds,
      progressValue: progressValue ?? this.progressValue,
      timer: timer ?? this.timer,
    );
  }
}

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) {
  return ForgotPasswordNotifier();
});
