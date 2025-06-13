import 'package:flutter/material.dart';

const defaultAutoValidateMode = AutovalidateMode.onUserInteraction;

String? requiredValidator<T>(T? value) {
  return (value == null || (value is String && value.trim().isEmpty)) ? 'Required' : null;
}
