import 'package:flutter/material.dart';

class ContextClass {
  ContextClass._();
  static final ContextClass instance = ContextClass._();

  Future<void> myAsyncMethod(BuildContext context, VoidCallback onSuccess) async {
    await Future.delayed(const Duration(seconds: 1));
    onSuccess.call();
  }
}