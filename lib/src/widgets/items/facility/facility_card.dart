import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/facility_item.dart';
import '../../../globals.dart';
import '../../items/item_card.dart';
import '../../media/app_image.dart';
import '../list_value/list_value_chip.dart';
import '../user/user_chip.dart';
import 'room_count_chip.dart';

typedef Builder = Widget Function(BuildContext context, WidgetRef ref);

const _cardHeight = 48.0;

final _defaultPicture = '$imagesPath/default_facility_picture.png';

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
      body: buildCardBody(
        imageWidget: SizedBox(
            width: _cardHeight,
            height: _cardHeight,
            child: ClipOval(
                child: item.avatar != null
                    ? AppFileImage(path: item.avatar!)
                    : AppAssetImage(assetPath: _defaultPicture))),
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
        typeWidget: ListValueChipConsumer(id: item.type, labelStyle: smallChipStyle),
        subtypeWidget: ListValueChipConsumer(id: item.subtype, labelStyle: smallChipStyle),
        roomCountWidget: RoomCountChip(roomCount: item.roomCount, labelStyle: smallChipStyle),
        statusWidget: ListValueChipConsumer(
          id: item.status,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          // TODO: remove hard coded value
          width: 85,
        ),
      ),
    );
  }

  Widget buildCardBody({
    required Widget imageWidget,
    required Widget numberWidget,
    required Widget ownerWidget,
    required Widget typeWidget,
    required Widget subtypeWidget,
    required Widget roomCountWidget,
    required Widget statusWidget,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          imageWidget,
          SizedBox(width: 10),
          numberWidget,
          SizedBox(width: 10),
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ownerWidget,
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
        ]),
        statusWidget,
      ],
    );
  }
}
