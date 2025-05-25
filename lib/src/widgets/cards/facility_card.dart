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

const _roomCountColors = <int, Color>{
  1: Color(0xFFe07657),
  2: Color(0xFF8465c6),
  3: Color(0xFFa2c65b),
  4: Color(0xFF6e9ce3),
  5: Color(0xFF32BB87),
};

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
            numberBuilder: (_) => _placeholderBuilder(55, _cardHeight),
            ownerBuilder: (_) => _placeholderBuilder(170, 20),
            typeBuilder: (_) => _placeholderBuilder(45, 16),
            subtypeBuilder: (_) => _placeholderBuilder(25, 16),
            roomCountBuilder: (_) => _placeholderBuilder(85, 16),
            statusBuilder: (_) => _placeholderBuilder(100, 40),
            buttonBuilders: [
              (_) => _placeholderBuilder(32, 32),
              (_) => _placeholderBuilder(32, 32),
            ],
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
    return Card(
      child: _cardContentBuilder(
        context: context,
        numberBuilder: _numberBuilder,
        ownerBuilder: (context) => _ownerBuilder(
          context: context,
          owner: owner,
        ),
        typeBuilder: (_) => _typeBuilder(type),
        subtypeBuilder: (_) => _subtypeBuilder(subtype),
        roomCountBuilder: (_) => _roomCountBuilder(facility.roomCount),
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
    required Builder numberBuilder,
    required Builder ownerBuilder,
    required Builder typeBuilder,
    required Builder subtypeBuilder,
    required Builder roomCountBuilder,
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
            // number
            numberBuilder(context),
            // owner / type
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ownerBuilder(context),
                  Spacer(),
                  Row(
                    children: [
                      typeBuilder(context),
                      SizedBox(width: 8),
                      subtypeBuilder(context),
                      SizedBox(width: 8),
                      roomCountBuilder(context),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(child: statusBuilder(context)),
            ...buttonBuilders.map((buttonBuilder) => buttonBuilder(context)),
          ],
        ),
      ),
    );
  }

  Widget _numberBuilder(BuildContext context) {
    return SizedBox(
      height: _cardHeight,
      width: 45,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '# ${facility.number.toString()}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _imageBuilder() {
    return SizedBox(
        width: _cardHeight,
        height: _cardHeight,
        child: ClipOval(child: AppImage(facility.mainPicture)));
  }

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
      dataBuilder: (status, _, __) => ListValueField(
        listValueItem: status,
        size: ValueChipSize.large,
      ),
    );
  }

  Widget _typeBuilder(ListValueItem type) => ListValueField(listValueItem: type);

  Widget _subtypeBuilder(ListValueItem subtype) => ListValueField(listValueItem: subtype);

  Widget _roomCountBuilder(int roomCount) =>
      ValueChip(title: Labels.facilityRoomCount(roomCount), color: _roomCountColors[roomCount]!);

  Widget _buttonBuilder({required IconData icon, GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Icon(icon, size: 20),
      ),
    );
  }

  Widget _placeholderBuilder(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void onEdit(BuildContext context) {
    final route = '/facility/${facility.id}';
    logger.t('[FacilityCard.onEdit] navigate to $route');
    context.push(route);
  }

  void onDelete() {}
}
