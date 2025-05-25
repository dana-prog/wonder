import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/providers/lists_of_values_provider.dart';
import 'package:wonder/src/providers/users_provider.dart';
import 'package:wonder/src/resources/labels.dart';
import 'package:wonder/src/widgets/async/async_value_widget.dart';
import 'package:wonder/src/widgets/fields/list_value_field.dart';

import '../../data/facility_item.dart';
import '../../data/user_item.dart';
import '../../logger.dart';
import '../media/app_image.dart';

typedef Builder = Widget Function(BuildContext context);

const _cardHeight = 48.0;

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

  Widget loadingBuilder(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: _cardContentBuilder(
            context: context,
            ownerBuilder: _ownerPlaceholderBuilder,
            typeBuilder: _typePlaceholderBuilder,
            statusBuilder: _statusPlaceholderBuilder,
            buttonBuilders: [_buttonPlaceholderBuilder, _buttonPlaceholderBuilder],
          )),
    );
  }

  Widget dataBuilder(
    UserItem? owner,
    ListValueItem status,
    ListValueItem type,
    ListValueItem subtype,
    BuildContext context,
    WidgetRef _,
  ) {
    // return loadingBuilder(context);
    return Card(
      child: _cardContentBuilder(
        context: context,
        ownerBuilder: (context) => _ownerBuilder(
          context: context,
          owner: owner,
        ),
        typeBuilder: (context) => _typeBuilder(
          type: type,
          subtype: subtype,
          context: context,
        ),
        statusBuilder: (_) => _statusBuilder(status: status),
        buttonBuilders: [
          (BuildContext context) => _buttonBuilder(
                icon: Icons.edit,
                onTap: () => onEdit(context),
              ),
          (BuildContext _) => _buttonBuilder(
                icon: Icons.delete,
                onTap: onDelete,
              ),
        ],
      ),
    );
  }

  Widget _cardContentBuilder({
    required BuildContext context,
    required Builder ownerBuilder,
    required Builder typeBuilder,
    required Builder statusBuilder,
    required List<Builder> buttonBuilders,
  }) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: SizedBox(
        height: _cardHeight,
        child: Row(
          spacing: 12,
          children: [
            // image
            _imageBuilder(),
            // owner / type
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ownerBuilder(context),
                    Spacer(),
                    typeBuilder(context),
                  ],
                ),
              ),
            ),
            Expanded(child: statusBuilder(context)),
            ...buttonBuilders.map((buttonBuilder) => buttonBuilder(context)),
          ],
        ),
      ),
    );
  }

  TextStyle _getSubtitleTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
  }

  Widget _imageBuilder() {
    return ClipOval(child: AppImage(facility.mainPicture));
  }

  // Widget _getImagePlaceholder() {
  //   final radius = 30.0;
  //
  //   return Container(
  //     width: radius * 2,
  //     height: radius * 2,
  //     decoration: BoxDecoration(
  //       color: Colors.black,
  //       borderRadius: BorderRadius.circular(radius),
  //     ),
  //   );
  // }

  Widget _ownerBuilder({
    required BuildContext context,
    required UserItem? owner,
  }) {
    final theme = Theme.of(context);
    return owner != null
        ? Text(
            owner.title,
            style: theme.textTheme.titleSmall,
          )
        : Text(
            Labels.noOwner,
            style: (theme.textTheme.titleSmall ?? const TextStyle())
                .copyWith(fontStyle: FontStyle.italic, color: Colors.grey.shade600),
          );
  }

  Widget _statusBuilder({required ListValueItem status}) {
    return AsyncValueProviderWidget<ListValueItem>(
      provider: listValueProvider(facility.status),
      dataBuilder: (status, _, __) => ListValueField(value: status),
    );
  }

  Widget _typeBuilder({
    required ListValueItem? type,
    required ListValueItem? subtype,
    required BuildContext context,
  }) {
    return Text(
      [
        type!.title,
        Labels.facilityRoomCount(facility.roomCount),
        subtype!.title,
      ].join(' - '),
      style: _getSubtitleTextStyle(context),
    );
  }

  Widget _buttonBuilder({required IconData icon, GestureTapCallback? onTap}) {
    return IconButton(onPressed: onTap, icon: Icon(icon));
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Padding(
    //     padding: EdgeInsets.all(4),
    //     child: Icon(icon, size: 16),
    //   ),
    // );
  }

  Widget _ownerPlaceholderBuilder(BuildContext _) {
    // return Text(Labels.noOwner);
    return Container(
      width: 150,
      height: 8.0,
      color: Colors.white,
    );
  }

  Widget _statusPlaceholderBuilder(BuildContext _) {
    return Container(
      width: 100,
      height: 12.0,
      color: Colors.white,
    );
  }

  Widget _typePlaceholderBuilder(BuildContext _) {
    return Container(
      width: 200,
      height: 8.0,
      color: Colors.white,
    );
  }

  Widget _buttonPlaceholderBuilder(BuildContext _) {
    return Container(color: Colors.white, height: 14, width: 14);
  }

  void onEdit(BuildContext context) {
    final route = '/facility/${facility.id}';
    logger.t('[FacilityCard.onEdit] navigate to $route');
    context.push(route);
  }

  void onDelete() {}
}
