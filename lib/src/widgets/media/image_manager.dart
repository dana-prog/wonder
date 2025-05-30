import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../storage/file_storage.dart';
import 'app_image.dart';

class ImageManager extends ConsumerWidget {
  final List<String> ids;
  final Future<String> Function(Stream<Uint8List> stream, String name)? save;
  final Future<void> Function(String id)? onAdd;
  final void Function(String id)? onRemove;

  const ImageManager({
    required this.ids,
    required this.onAdd,
    required this.onRemove,
    this.save,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileStorage = ref.watch(fileStorageProvider);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...ids.map((id) => Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AppImage(id: id, width: 100, height: 100),
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: 18),
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith<Color?>(
                      (states) => states.contains(WidgetState.hovered) ? Colors.blue : null,
                    ),
                  ),
                  onPressed: () => onRemove?.call(id),
                ),
              ],
            )),
        InkWell(
          onTap: () async {
            final picker = ImagePicker();
            final picked = await picker.pickImage(source: ImageSource.gallery);
            if (picked != null) {
              final id = await (save ?? fileStorage.saveFile).call(picked.openRead(), picked.name);
              onAdd?.call(id);
            }
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add_a_photo),
          ),
        ),
      ],
    );
  }
}
