import 'package:flutter/material.dart';

import '../../../platform/constants.dart';

class FacilityNumberTextBox extends StatelessWidget {
  final int? initialValue;
  final ValueChanged<int?>? onChanged;

  const FacilityNumberTextBox({super.key, this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kFieldEditorHeight,
      child: TextFormField(
        initialValue: initialValue?.toString(),
        decoration: InputDecoration(
          // set isDense to true to avoid extra top padding
          isDense: true,
          // set filled to true to add background color
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            // TODO: remove hard coded value (unify with the one in dropdown)
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        keyboardType: TextInputType.number,
        // textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        onChanged: (value) => onChanged?.call(value.isEmpty ? null : int.tryParse(value)),
      ),
    );
  }
}
