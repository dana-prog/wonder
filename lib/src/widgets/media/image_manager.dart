import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_theme.dart';
import '../../logger.dart';
import '../../providers/file_provider.dart';
import '../platform/dotted_border.dart';
import 'app_image.dart';

const _imageDefaultWidth = 100.0;

const _imagesHorizontalSpace = 16.0;
const _imagesVerticalSpace = 16.0;

typedef AddImageCallback = Future<void> Function(String id);
typedef RemoveImageCallback = void Function(String id);

class ImageManager extends StatelessWidget {
  final List<String> ids;
  final Future<String> Function(Stream<Uint8List> stream, String name)? save;
  final AddImageCallback? onAdd;
  final RemoveImageCallback? onRemove;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const ImageManager({
    required this.ids,
    required this.onAdd,
    required this.onRemove,
    this.save,
    this.padding,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            // borderRadius: BorderRadius.circular(8)),
          ),
        ),
        child: buildImages(),
      ),
    );
  }

  Widget buildImages() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final estTotalImageWidth = _imageDefaultWidth + _imagesHorizontalSpace;
        final rowImageCount = (constraints.maxWidth / estTotalImageWidth).floor();
        final space = _imagesHorizontalSpace * (rowImageCount - 1);
        final size = (constraints.maxWidth - space) / rowImageCount;
        return Wrap(
          spacing: _imagesHorizontalSpace,
          runSpacing: _imagesVerticalSpace,
          children: [
            ...ids.map((id) => buildImage(id: id, width: size, height: size)),
            onAdd != null
                ? _AddImagePlaceholder(onAdd: onAdd!, width: size, height: size)
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }

  Widget buildImage({required String id, double? width, double? height}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = (constraints.maxWidth - _imagesHorizontalSpace) / 2;
        return _ImageThumbnail(
          path: id,
          width: width ?? size,
          height: height ?? size,
          onRemove: onRemove,
        );
      },
    );
  }

  Widget buildAddImagePlaceholder(fileStorage, context) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = (constraints.maxWidth - 2 * _removeBtnPadding) / 3;
      return InkWell(
        onTap: () async {
          final picker = ImagePicker();
          final picked = await picker.pickImage(source: ImageSource.gallery);
          if (picked != null) {
            final id = await (save ?? fileStorage.saveFile).call(picked.openRead(), picked.name);
            onAdd?.call(id);
          }
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.add_a_photo),
        ),
      );
    });
  }
}

class _ImageThumbnail extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final RemoveImageCallback? onRemove;

  const _ImageThumbnail({
    required this.path,
    this.onRemove,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          child: AppFileImage(path: path, width: width, height: height),
        ),
        onRemove != null
            ? Padding(
                padding: EdgeInsets.all(_removeBtnPadding),
                child: _RemoveButton(id: path, onRemove: onRemove!),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

const _removeBtnSize = 16.0;
const _removeBtnPadding = 3.0;
const _removeBtnIconSize = 12.0;
final _removeBtnBackgroundColor = WidgetStateProperty.all<Color>(Colors.white);
final _removeBtnForegroundColor = WidgetStateProperty.all(Colors.grey.shade700);

class _RemoveButton extends StatelessWidget {
  final String id;
  final void Function(String id) onRemove;

  const _RemoveButton({
    required this.id,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _removeBtnSize,
      height: _removeBtnSize,
      child: FilledButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(const CircleBorder()),
          padding: WidgetStateProperty.all(EdgeInsets.all(0)),
          backgroundColor: _removeBtnBackgroundColor,
          foregroundColor: _removeBtnForegroundColor,
        ),
        onPressed: () {
          logger.d('[ImageManager] Removing image with id: $id');
          onRemove(id);
        },
        child: const Icon(Icons.close, size: _removeBtnIconSize),
      ),
    );
  }
}

class _AddImagePlaceholder extends ConsumerWidget {
  final AddImageCallback onAdd;
  final double? width;
  final double? height;

  const _AddImagePlaceholder({
    required this.onAdd,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileStorage = ref.watch(fileStorageProvider);

    return InkWell(
      onTap: () async {
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: ImageSource.gallery);
        if (picked == null) {
          logger.d('[ImageManager] No image selected');
          return;
        }

        final id = await fileStorage.saveFile(picked.openRead(), picked.name);
        await onAdd(id);
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
