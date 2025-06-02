import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/item.dart';
import '../../logger.dart';
import '../../providers/items_provider.dart';
import '../../resources/labels.dart';
import '../overlay/blurred_overlay.dart';
import 'item_form.dart';

typedef ItemCardLayoutBuilder = Widget Function(BuildContext context, WidgetRef ref, Item item);

class ItemCard extends ConsumerWidget {
  final Item item;
  final Widget body;
  final bool canEdit;
  final bool canDelete;

  const ItemCard({
    required this.item,
    required this.body,
    this.canEdit = true,
    this.canDelete = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _onEdit(context),
      child: Card(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: body),
              buildButtons(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (canDelete) _deleteButtonBuilder(context, ref),
        if (canEdit) _editButtonBuilder(context, ref),
      ],
    );
  }

  void _onDelete(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(itemListProvider(item.itemType).notifier);
    final confirmed = await _confirmDelete(context: context, item: item);
    if (confirmed != true) return;

    await notifier.delete(item);
  }

  void _onEdit(BuildContext context) {
    final route = '/${item.itemType}/${item.id}';
    logger.d('[ItemCard.onEdit] navigate to $route');
    Navigator.of(context).push(
      // TODO: check this solution again: it might be a problem when we want to share the route (to send a ticket link for example)
      PageRouteBuilder(
        opaque: false,
        // TODO: [THEME]
        barrierColor: Colors.black38, // dim background
        pageBuilder: (_, __, ___) => BlurredOverlay(
          child: ItemFormConsumer(itemType: item.itemType, id: item.id),
        ),
      ),
    );
  }

  Future<bool> _confirmDelete({
    required BuildContext context,
    required Item item,
  }) async {
    final res = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${Labels.delete}?'),
        content: Text(ConfirmationMessages.delete(item)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true), child: const Text(Labels.delete)),
        ],
      ),
    );
    return res ?? false;
  }

  Widget _buttonBuilder({required IconData icon, GestureTapCallback? onTap}) {
    return RawMaterialButton(
      onPressed: onTap,
      constraints: BoxConstraints.tight(Size(32, 32)),
      child: Icon(icon, size: 20),
    );
  }

  Widget _deleteButtonBuilder(BuildContext context, WidgetRef ref) {
    return _buttonBuilder(
      icon: Icons.delete,
      onTap: () {
        _onDelete(context, ref);
      },
    );
  }

  Widget _editButtonBuilder(BuildContext context, WidgetRef _) => _buttonBuilder(
        icon: Icons.edit,
        onTap: () => _onEdit(context),
      );
}
