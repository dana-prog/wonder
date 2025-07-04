import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/facility_item.dart';
import '../../../globals.dart';
import '../../items/item_card.dart';
import '../../media/app_image.dart';
import '../list_value/list_value_chip.dart';
import '../user/user_chip.dart';
import 'fields/room_count_chip.dart';

typedef Builder = Widget Function(BuildContext context, WidgetRef ref);

// TODO: replace with k...
const _cardHeight = 48.0;

final _defaultPicture = '$imagesPath/default_facility.png';

class FacilityCard extends ConsumerWidget {
  final FacilityItem item;

  FacilityCard({required this.item}) : super(key: ValueKey(item.id));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smallChipStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
      fontWeight: FontWeight.bold,
    );

    return ItemCard(
      item: item,
      body: buildBody(
        imageWidget: SizedBox(
            width: _cardHeight,
            height: _cardHeight,
            child: ClipOval(
                child: item.avatar != null
                    ? AppImage(fileUrl: item.avatar!)
                    : AppImage(assetName: _defaultPicture))),
        numberWidget: SizedBox(
          height: _cardHeight,
          // TODO: remove hard coded value
          width: 65,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item.displayNumber,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        ownerWidget: UserChipConsumer(
          id: item.owner,
          width: double.infinity,
        ),
        statusWidget: ListValueChipConsumer(
          id: item.status,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          width: double.infinity,
          textAlign: TextAlign.center,
        ),
        typeWidget: ListValueChipConsumer(id: item.type, labelStyle: smallChipStyle),
        subtypeWidget: ListValueChipConsumer(id: item.subtype, labelStyle: smallChipStyle),
        roomCountWidget: RoomCountChip(roomCount: item.roomCount, labelStyle: smallChipStyle),
      ),
    );
  }

  Widget buildBody({
    required Widget imageWidget,
    required Widget numberWidget,
    required Widget ownerWidget,
    required Widget statusWidget,
    required Widget typeWidget,
    required Widget subtypeWidget,
    required Widget roomCountWidget,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        // aad a row with all widgets except statusWidget to align these widgets to start while the status widgets is aligned to end
        // wrap the row in Flexible so that it will not try to take more space than available and overflow
        Flexible(
          flex: 3,
          child: Row(
            spacing: 10,
            children: [
              imageWidget,
              numberWidget,
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ownerWidget,
                      buildSubsection(
                          typeWidget: typeWidget,
                          subtypeWidget: subtypeWidget,
                          roomCountWidget: roomCountWidget)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: statusWidget,
        ),
      ],
    );
  }

  Widget buildSubsection({
    required Widget typeWidget,
    required Widget subtypeWidget,
    required Widget roomCountWidget,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        typeWidget,
        subtypeWidget,
        roomCountWidget,
      ],
    );
  }
}
