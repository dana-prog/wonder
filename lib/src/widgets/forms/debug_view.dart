import 'package:flutter/material.dart';
import '../platform/dropdown.dart';

import '../../logger.dart';
import '../items/facility/room_count_dropdown.dart';

final _options = [
  OptionProps(value: 'dropdowns', title: 'Dropdowns', color: Colors.pink.shade200),
  OptionProps(value: 'test', title: 'Test', color: Colors.brown.shade400),
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
            const SizedBox(width: 8),
            Expanded(child: getDebugWidget()),
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
        return const DropdownsPlayground();
      case 'test':
        return const Center(child: Text('Test debug view'));
      default:
        logger.w('[DebugView.getDebugWidget] No debug widget found for: $_input');
        return const SizedBox();
    }
  }

  void onRoomCountChanged() {}
}

class DropdownsPlayground extends StatefulWidget {
  const DropdownsPlayground();

  @override
  State<DropdownsPlayground> createState() => _DropdownsPlaygroundState();
}

class _DropdownsPlaygroundState extends State<DropdownsPlayground> {
  int? _roomCount = 3;

  _DropdownsPlaygroundState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoomCountDropdown(
          value: _roomCount,
          onChanged: (value) => setState(() => _roomCount = value),
        ),
        SampleDropdown1(
            value: _roomCount,
            onChanged: (value) {
              setState(
                () {
                  _roomCount = value;
                },
              );
            }),
      ],
    );
  }
}

class SampleDropdown1 extends StatelessWidget {
  static const options = [1, 2, 3];
  final int? value;
  final ValueChanged<int?>? onChanged;

  const SampleDropdown1({
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // not working
    // return Dropdown<int>(
    //   value: value,
    //   // labelText: ItemsLabels.getFieldLabels('facility')['roomCount'],
    //   items: menuItemsProps,
    // );

    // working
    return DropdownButtonFormField<int>(
      value: value,
      items: menuItemsProps.map((item) => getMenuItem(item, context)).toList(),
      onChanged: onChanged,
    );
  }

  DropdownMenuItem<int> getMenuItem(OptionProps<int> dropdownItem, BuildContext context) {
    return DropdownMenuItem<int>(value: dropdownItem.value, child: Text(dropdownItem.title));
  }
}
