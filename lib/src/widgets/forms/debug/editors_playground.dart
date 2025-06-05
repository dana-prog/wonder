import 'package:flutter/material.dart';

import '../../items/facility/room_count_dropdown.dart';
import '../../platform/field_label.dart';

class EditorsPlayground extends StatefulWidget {
  const EditorsPlayground();

  @override
  State<EditorsPlayground> createState() => _EditorsPlaygroundState();
}

class _EditorsPlaygroundState extends State<EditorsPlayground> {
  int? _roomCount = 3;

  _EditorsPlaygroundState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        RoomCountDropdown(
          value: _roomCount,
          onChanged: (value) => setState(() => _roomCount = value),
        ),
        TextFieldDemo(),
        ButtonsDemo(),
      ],
    );
  }
}

class TextFieldDemo extends StatelessWidget {
  final String? value;
  final ValueChanged<String?>? onChanged;

  const TextFieldDemo({
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FieldLabel(
      label: 'Text Field',
      child: SizedBox(
        height: 48,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.end,
          initialValue: 'This is a text field',
          // decoration: InputDecoration(labelText: 'Text Field'),
          // controller: TextEditingController(text: value),
        ),
      ),
    );
  }
}

class ButtonsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // logger.d(
    //     '[EditorsPlayground.ButtonsDemo] FilledButton.style: ${Theme.of(context).filledButtonTheme.style}');
    return Row(
      spacing: 10,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('Press Me'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red),
              ),
            ),
          ),
          child: Icon(Icons.add),
        ),
        IconButton(icon: Icon(Icons.delete), onPressed: () {}),
        FilledButton(onPressed: () {}, child: Text('Filled Button')),
        FilledButton(
          onPressed: () {},
          style: ButtonStyle(
              shape: WidgetStateProperty.all<CircleBorder>(
            CircleBorder(),
          )),
          child: Icon(Icons.delete),
        ),
        FilledButton.tonal(
          onPressed: () {},
          style: ButtonStyle(
              shape: WidgetStateProperty.all<CircleBorder>(
            CircleBorder(),
          )),
          child: Icon(Icons.delete),
        ),
      ],
    );
  }
}
