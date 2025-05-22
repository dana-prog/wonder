import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
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
    return AsyncValueProviderWidget4<UserItem?, ListValueItem, ListValueItem, ListValueItem>(
      provider1: facility.owner != null ? userProvider(facility.owner!) : noUserProvider,
      provider2: listValueProvider(facility.status),
      provider3: listValueProvider(facility.type),
      provider4: listValueProvider(facility.subtype),
      loadingBuilder: loadingBuilder,
      dataBuilder: dataBuilder,
    );
  }

  Widget loadingBuilder(_) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: ListTile(
          leading: getLeadingPlaceholder(),
          title: getTitlePlaceholder(),
          trailing: getTrailingPlaceholder(),
        ),
      ),
    );
  }

  Widget dataBuilder(
    UserItem? user,
    ListValueItem status,
    ListValueItem type,
    ListValueItem subtype,
    BuildContext context,
    WidgetRef _,
  ) {
    return Card(
      child: ListTile(
        leading: getLeading(),
        title: getTitle(context: context, type: type, subtype: subtype, owner: user),
        trailing: getTrailing(status: status),
      ),
    );
  }

  TextStyle getSubtitleTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
  }

  Widget getLeading() {
    final radius = 30.0;

    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: ClipOval(
        child: AppImage(facility.mainPicture),
      ),
    );
  }

  Widget getLeadingPlaceholder() {
    final radius = 30.0;

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget getTitle({
    required BuildContext context,
    required ListValueItem type,
    required ListValueItem subtype,
    required UserItem? owner,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getOwner(owner: owner),
        getDetails(
          context: context,
          type: type,
          subtype: subtype,
        ),
      ],
    );
  }

  Widget getTitlePlaceholder() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          height: 12.0,
          color: Colors.white,
        ),
        const SizedBox(height: 8.0),
        Container(
          width: 200,
          height: 12.0,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget getOwner({required UserItem? owner}) {
    return owner != null ? Text(owner.title) : const Text(Labels.noOwner);
  }

  Widget getTrailing({required ListValueItem status}) {
    return AsyncValueProviderWidget<ListValueItem>(
      provider: listValueProvider(facility.status),
      dataBuilder: (status, _, __) => Text.rich(TextSpan(
        children: [
          TextSpan(text: status.title),
          TextSpan(text: ' '),
          WidgetSpan(
            // alignment: PlaceholderAlignment.middle,
            child: Icon(ValueItemIcons.getIcon(status), size: 16),
          ),
        ],
      )),
    );
  }

  Widget getTrailingPlaceholder() {
    return Container(
      width: 100,
      height: 12.0,
      color: Colors.white,
    );
  }

  Widget getDetails({
    required BuildContext context,
    required ListValueItem? type,
    required ListValueItem? subtype,
  }) {
    return Text(
      [
        type!.title,
        Labels.facilityRoomCount(facility.roomCount),
        subtype!.title,
      ].join(' - '),
      style: getSubtitleTextStyle(context),
    );
  }
}
