import 'package:flutter/material.dart';
import 'package:wonder/src/data/list_value_item.dart';

class ListValueField extends StatelessWidget {
  final ListValueItem value;

  const ListValueField({required this.value});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: value.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            value.title,
            textAlign: TextAlign.center,
            style: DefaultTextStyle.of(context).style.copyWith(
                  // backgroundColor: value.color,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      );
}
