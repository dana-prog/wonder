import 'package:flutter/material.dart' hide Chip;

import '../../../resources/colors.dart';
import '../../../resources/labels.dart';
import '../../platform/chip.dart';

class RoomCountChip extends StatelessWidget {
  final int roomCount;
  final TextStyle? labelStyle;

  const RoomCountChip({
    required this.roomCount,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Labels.facilityRoomCount(roomCount),
      labelStyle: labelStyle,
      backgroundColor: roomCountColors[roomCount]!,
    );
  }
}
