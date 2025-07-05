import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:wonder/src/storage/file_storage_plugin.dart';
import 'package:wonder/src/widgets/progress_indicator/app_progress_indicator.dart';

import '../../logger.dart';
import '../../providers/file_provider.dart';
import '../../router/routes_names.dart';
import '../../theme/app_theme.dart';
import '../platform/dotted_border.dart';
import 'app_image.dart';

const _imageDefaultWidth = 100.0;

const _imagesHorizontalSpace = 16.0;
const _imagesVerticalSpace = 16.0;

typedef AddImageCallback = Future<void> Function(String id);
typedef RemoveImageCallback = void Function(String id);

class ImageManager extends StatelessWidget {
  final List<String> fileUrls;
  final FileContext fileContext;
  final Future<String> Function(Stream<Uint8List> stream, String name)? save;
  final AddImageCallback? onAdd;
  final RemoveImageCallback? onRemove;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const ImageManager({
    required this.fileUrls,
    required this.onAdd,
    required this.onRemove,
    required this.fileContext,
    this.save,
    this.padding,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return ImageManagerBorder(child: buildImages());
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
            ...fileUrls.map((fileUrl) => buildImage(fileUrl: fileUrl, width: size, height: size)),
            onAdd != null
                ? AddImagePlaceholder(
                    onAdd: onAdd!,
                    fileContext: fileContext,
                    width: size,
                    height: size,
                  )
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }

  Widget buildImage({required String fileUrl, double? width, double? height}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = (constraints.maxWidth - _imagesHorizontalSpace) / 2;
        return _ImageThumbnail(
          fileUrl: fileUrl,
          width: width ?? size,
          height: height ?? size,
          onRemove: onRemove,
        );
      },
    );
  }
}

class ImageManagerBorder extends StatelessWidget {
  final Widget child;

  const ImageManagerBorder({required this.child});

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
        child: child,
      ),
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  final String fileUrl;
  final double? width;
  final double? height;
  final RemoveImageCallback? onRemove;

  const _ImageThumbnail({
    required this.fileUrl,
    this.onRemove,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: () {
            context.push(RouteNames.file.replaceFirst(':path', fileUrl));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            child: AppImage(fileUrl: fileUrl, width: width, height: height),
          ),
        ),
        onRemove != null
            ? Padding(
                padding: EdgeInsets.all(_removeBtnPadding),
                child: _RemoveButton(path: fileUrl, onRemove: onRemove!),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

// TODO: [THEME]
const _removeBtnSize = 16.0;
const _removeBtnPadding = 3.0;
const _removeBtnIconSize = 12.0;

// TODO: [THEME]
// final _removeBtnBackgroundColor = WidgetStateProperty.all<Color>(Colors.white);
// final _removeBtnForegroundColor = WidgetStateProperty.all(Colors.grey.shade700);

class AddImagePlaceholder extends ConsumerStatefulWidget {
  final AddImageCallback onAdd;
  final FileContext fileContext;
  final double? width;
  final double? height;

  const AddImagePlaceholder({
    required this.onAdd,
    required this.fileContext,
    this.width,
    this.height,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddImagePlaceholderState();
}

class _AddImagePlaceholderState extends ConsumerState<AddImagePlaceholder> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final fileStorage = ref.watch(fileStorageProvider);

    return InkWell(
      onTap: () async {
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: ImageSource.gallery);
        if (picked == null) {
          logger.d('[ImageManager] No image selected');
          return;
        }

        final mimeType = picked.mimeType ?? lookupMimeType(picked.name);
        if (mimeType == null) {
          logger.e('[ImageManager] Unidentified mime type for ${picked.name}');
          return;
        }

        setState(() => isLoading = true);

        final fileBytes = await picked.readAsBytes();
        final id = await fileStorage.add(
          fileBytes: fileBytes,
          name: picked.name,
          mimeType: picked.mimeType ?? lookupMimeType(picked.name) ?? '',
          fileContext: widget.fileContext,
        );

        if (id == null || id.isEmpty) {
          logger.w('[ImageManager] Failed to add image: ${picked.name}');
          return;
        }

        await widget.onAdd(id);
        isLoading = false;
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: isLoading ? AppProgressIndicator(size: 24) : const Icon(Icons.add_a_photo),
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  final String path;
  final void Function(String id) onRemove;

  const _RemoveButton({
    required this.path,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final deleteIconColor = ChipTheme.of(context).deleteIconColor ?? Colors.black87;

    return SizedBox(
      width: _removeBtnSize,
      height: _removeBtnSize,
      child: FilledButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(const CircleBorder()),
          padding: WidgetStateProperty.all(EdgeInsets.all(0)),
          backgroundColor: WidgetStateProperty.all<Color>(deleteIconColor),
          // foregroundColor: _removeBtnForegroundColor,
        ),
        onPressed: () {
          logger.d('[ImageManager] Removing image with path: $path');
          onRemove(path);
        },
        child: const Icon(Icons.close, size: _removeBtnIconSize),
      ),
    );
  }
}
