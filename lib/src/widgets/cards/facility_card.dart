import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/providers/lists_of_values_provider.dart';
import 'package:wonder/src/providers/users_provider.dart';
import 'package:wonder/src/resources/labels.dart';
import 'package:wonder/src/resources/value_item_icons.dart';
import 'package:wonder/src/widgets/async/async_value_widget.dart';

import '../../data/facility_item.dart';
import '../../data/user_item.dart';
import '../media/app_image.dart';

class FacilityCard extends StatelessWidget {
  final FacilityItem facility;

  FacilityCard(this.facility) : super(key: ValueKey(facility.id));

  @override
  Widget build(BuildContext context) {
    final radius = 30.0;

    return AsyncValueProviderWidget4<UserItem?, ListValueItem, ListValueItem, ListValueItem>(
      facility.owner != null
          ? userProvider(facility.owner!)
          : FutureProvider((_) async {
              return null;
            }),
      listValueProvider(facility.status),
      listValueProvider(facility.type),
      listValueProvider(facility.subtype),
      showNoDataIndicator: false,
      showProgressIndicator: false,
      (
        user,
        status,
        type,
        subtype,
        _,
        __,
      ) {
        return Card(
          child: ListTile(
            leading: SizedBox(
                width: radius * 2,
                height: radius * 2,
                child: ClipOval(
                  child: AppImage(facility.mainPicture),
                )),
            title: getTitle(
              facility.number,
              facility.roomCount,
              user,
              type,
              subtype,
              context,
            ),
            trailing: getTrailing(status),
            // onTap: () => navigateToItem(
            //   item.id,
            //   context,
            // ),
          ),
        );
      },
    );
  }

  TextStyle getSubtitleTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
  }

  Widget getTitle(
    int number,
    int roomCount,
    UserItem? owner,
    ListValueItem type,
    ListValueItem subtype,
    BuildContext context,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Text('#$number'),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(owner != null ? owner.title : Labels.noOwner),
            Text(
              [
                type.title,
                Labels.facilityRoomCount(roomCount),
                subtype.title,
              ].join(' - '),
              style: getSubtitleTextStyle(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget getTrailing(ListValueItem status) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: status.title),
          TextSpan(text: ' '),
          WidgetSpan(
            // alignment: PlaceholderAlignment.middle,
            child: Icon(ValueItemIcons.getIcon(status), size: 16),
          ),
        ],
      ),
    );
  }
}
