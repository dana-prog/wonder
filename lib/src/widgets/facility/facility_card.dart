import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/resources/labels.dart';
import 'package:wonder/src/widgets/fields/chip.dart';
import 'package:wonder/src/widgets/list_value/list_value_chip.dart';
import 'package:wonder/src/widgets/user/user_chip.dart';

import '../../data/facility_item.dart';
import '../fields/item_chip.dart';
import '../item/item_card.dart';
import '../media/app_image.dart';
import 'constants.dart';

typedef Builder = Widget Function(BuildContext context, WidgetRef ref);

const _cardHeight = 48.0;
const _smallChipTextStyle = TextStyle(fontSize: 11);

class FacilityCard extends ConsumerWidget {
  final FacilityItem item;

  FacilityCard({required this.item}) : super(key: ValueKey(item.id));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ItemCard(
      item: item,
      layout: buildCardLayout(
        imageWidget: SizedBox(
            width: _cardHeight,
            height: _cardHeight,
            child: ClipOval(child: AppImage(item.mainPicture))),
        numberWidget: SizedBox(
          height: _cardHeight,
          width: 65,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '# ${item.number.toString().padLeft(3, '0')}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        ownerWidget: UserChipConsumer(id: item.owner),
        typeWidget: ListValueChipConsumer(id: item.type, labelStyle: _smallChipTextStyle),
        subtypeWidget: ListValueChipConsumer(id: item.subtype, labelStyle: _smallChipTextStyle),
        roomCountWidget: Chip(
          label: Labels.facilityRoomCount(item.roomCount),
          labelStyle: _smallChipTextStyle,
          backgroundColor: roomCountColors[item.roomCount]!,
        ),
        statusWidget: ItemChipConsumer(
          itemType: 'listValue',
          id: item.status,
          width: 120,
        ),
      ),
    );
  }

  Iterable<Widget> buildCardLayout({
    required Widget imageWidget,
    required Widget numberWidget,
    required Widget ownerWidget,
    required Widget typeWidget,
    required Widget subtypeWidget,
    required Widget roomCountWidget,
    required Widget statusWidget,
  }) {
    return [
      // image
      imageWidget,
      SizedBox(width: 10),
      // number
      numberWidget,
      SizedBox(width: 10),
      // owner / type, subtype, room count
      Expanded(
        flex: 2,
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ownerWidget,
            // Spacer(),
            Row(
              children: [
                typeWidget,
                SizedBox(width: 8),
                subtypeWidget,
                SizedBox(width: 8),
                roomCountWidget,
              ],
            ),
          ],
        ),
      ),
      // // status
      // statusWidget,
    ];
  }
}
