import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wonder/src/providers/lists_of_values_provider.dart';
import 'package:wonder/src/resources/labels.dart';
import 'package:wonder/src/widgets/fields/value_chip.dart';

import '../../data/facility_item.dart';
import '../../logger.dart';
import '../../providers/users_provider.dart';
import '../media/app_image.dart';
import 'constants.dart';

typedef Builder = Widget Function(BuildContext context, WidgetRef ref);

const _cardHeight = 48.0;

class FacilityCard extends ConsumerWidget {
  final FacilityItem facility;
  final void Function(FacilityItem) onDelete;

  FacilityCard({
    required this.facility,
    required this.onDelete,
  }) : super(key: ValueKey(facility.id));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: _cardContentBuilder(
        context: context,
        ref: ref,
        imageBuilder: _imageBuilder,
        numberBuilder: _numberBuilder,
        ownerBuilder: _ownerBuilder,
        typeBuilder: _typeBuilder,
        subtypeBuilder: _subtypeBuilder,
        roomCountBuilder: _roomCountBuilder,
        statusBuilder: _statusBuilder,
        buttonBuilders: [_editButtonBuilder, _deleteButtonBuilder],
      ),
    );
  }

  Widget _numberBuilder(BuildContext context, WidgetRef __) {
    return SizedBox(
      height: _cardHeight,
      width: 65,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '# ${facility.number.toString().padLeft(3, '0')}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _imageBuilder(BuildContext _, WidgetRef __) {
    return SizedBox(
        width: _cardHeight,
        height: _cardHeight,
        child: ClipOval(child: AppImage(facility.mainPicture)));
  }

  Widget _ownerBuilder(
    BuildContext context,
    WidgetRef ref,
  ) {
    final owner = facility.owner != null ? ref.watch(userProvider(facility.owner!)) : null;
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

  Widget _statusBuilder(BuildContext context, WidgetRef ref) {
    final status = ref.watch(listValueProvider(facility.status));
    return ListValueField(
      listValueItem: status,
      size: ValueChipSize.large,
      width: 120,
    );
  }

  Widget _typeBuilder(BuildContext context, WidgetRef ref) {
    final type = ref.watch(listValueProvider(facility.type));
    return ListValueField(listValueItem: type, textStyle: TextStyle(fontSize: 11));
  }

  Widget _subtypeBuilder(BuildContext context, WidgetRef ref) {
    final subtype = ref.watch(listValueProvider(facility.subtype));
    return ListValueField(listValueItem: subtype);
  }

  Widget _roomCountBuilder(BuildContext context, WidgetRef ref) {
    final roomCount = facility.roomCount;
    return ValueChip(
        title: Labels.facilityRoomCount(roomCount), color: roomCountColors[roomCount]!);
  }

  Widget _buttonBuilder({required IconData icon, GestureTapCallback? onTap}) {
    return RawMaterialButton(
      onPressed: onTap,
      constraints: BoxConstraints.tight(Size(32, 32)),
      child: Icon(icon, size: 20),
    );
  }

  Widget _editButtonBuilder(BuildContext context, WidgetRef ref) => _buttonBuilder(
        icon: Icons.edit,
        onTap: () => _onEdit(context),
      );

  Widget _deleteButtonBuilder(BuildContext context, WidgetRef ref) => _buttonBuilder(
        icon: Icons.delete,
        onTap: () {
          logger.t('[FacilityCard._deleteButtonBuilder] ${facility.id}');
          onDelete(facility);
        },
      );

  void _onEdit(BuildContext context) {
    final route = '/facility/${facility.id}';
    logger.t('[FacilityCard.onEdit] navigate to $route');
    context.push(route);
  }
}

class FacilityLoadingCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: _cardContentBuilder(
          context: context,
          ref: ref,
          imageBuilder: (_, __) =>
              _placeholderBuilder(width: _cardHeight, height: _cardHeight, child: ClipOval()),
          numberBuilder: (_, __) => _placeholderBuilder(width: 55, height: _cardHeight),
          ownerBuilder: (_, __) => _placeholderBuilder(width: 170, height: 20),
          typeBuilder: (_, __) => _placeholderBuilder(width: 45, height: 16),
          subtypeBuilder: (_, __) => _placeholderBuilder(width: 25, height: 16),
          roomCountBuilder: (_, __) => _placeholderBuilder(width: 85, height: 16),
          statusBuilder: (_, __) => _placeholderBuilder(width: 100, height: 40),
          buttonBuilders: [
            (_, __) => _placeholderBuilder(width: 32, height: 32),
            (_, __) => _placeholderBuilder(width: 32, height: 32),
          ],
        ),
      ),
    );
  }

  Widget _placeholderBuilder({
    Widget? child,
    double? width,
    double? height,
  }) =>
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child ?? const SizedBox.shrink(),
      );
}

Widget _cardContentBuilder({
  required BuildContext context,
  required WidgetRef ref,
  required Builder imageBuilder,
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
        children: [
          // image
          imageBuilder(context, ref),
          SizedBox(width: 10),
          // number
          numberBuilder(context, ref),
          SizedBox(width: 10),
          // owner / type, subtype, room count
          Expanded(
            flex: 2,
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ownerBuilder(context, ref),
                  Spacer(),
                  Row(
                    children: [
                      typeBuilder(context, ref),
                      SizedBox(width: 8),
                      subtypeBuilder(context, ref),
                      SizedBox(width: 8),
                      roomCountBuilder(context, ref),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // status
          statusBuilder(context, ref),
          SizedBox(width: 10),
          // buttons
          ...buttonBuilders.map((buttonBuilder) => buttonBuilder(context, ref)),
        ],
      ),
    ),
  );
}
