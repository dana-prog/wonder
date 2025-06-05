import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/platform/field_label.dart';

import '../../logger.dart';
import '../items/facility/room_count_dropdown.dart';
import '../platform/dropdown.dart';

final _options = [
  DropdownOptionProps(value: 'editors', title: 'Editors Playground', color: Colors.pink.shade200),
  DropdownOptionProps(value: 'test', title: 'Test', color: Colors.brown.shade400),
];

class DebugView extends StatefulWidget {
  const DebugView({super.key});

  @override
  State<StatefulWidget> createState() => _DebugViewState();
}

class _DebugViewState extends State<DebugView> {
  String? _input = 'dropdowns';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Dropdown<String>(
              value: _input,
              optionsProps: _options,
              onChanged: (val) => setState(() => _input = val),
            ),
            const SizedBox(height: 32),
            Expanded(child: Container(decoration: BoxDecoration(), child: getDebugWidget())),
          ],
        ),
      ),
    );
  }

  Widget getDebugWidget() {
    logger.d('[DebugViewDebugView.getDebugWidget] widgetName: $_input');

    if (_input == null) {
      return const SizedBox();
    }

    switch (_input) {
      case 'dropdowns':
        return const EditorsPlayground();
      case 'test':
        return const Center(child: Text('Test debug view'));
      default:
        logger.w('[DebugView.getDebugWidget] No debug widget found for: $_input');
        return const SizedBox();
    }
  }

  void onRoomCountChanged() {}
}

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

// class SampleDropdown1 extends StatelessWidget {
//   static const options = [1, 2, 3];
//   final int? value;
//   final ValueChanged<int?>? onChanged;
//
//   const SampleDropdown1({
//     this.value,
//     this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // not working
//     // return Dropdown<int>(
//     //   value: value,
//     //   // labelText: ItemsLabels.getFieldLabels('facility')['roomCount'],
//     //   items: menuItemsProps,
//     // );
//
//     // working
//     return DropdownButtonFormField<int>(
//       value: value,
//       items: menuItemsProps
//           .map(
//             (dropdownItem) => DropdownMenuItem<int>(
//               value: dropdownItem.value,
//               child: Text(dropdownItem.title),
//             ),
//           )
//           .toList(),
//       onChanged: onChanged,
//     );
//   }
// }
