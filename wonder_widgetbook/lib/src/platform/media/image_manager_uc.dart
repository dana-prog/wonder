import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/src/storage/file_storage_plugin.dart';
import 'package:wonder/src/widgets/media/image_manager.dart';

import '../../folders.dart';
import '../../logger.dart';

const _folder = '${FolderNames.platform}/[ImageManager]';
final _pictures = <String>[];
final fileContext = FileContext(
  itemType: 'facility',
  itemId: '1',
  fieldName: '_pictures',
);

@UseCase(name: 'Default', type: ImageManager, path: _folder)
Widget imageManager(BuildContext context) => ImageManager(
      fileUrls: _pictures,
      fileContext: fileContext,
      onAdd: (String id) async {
        logger.d('[ImageManagerIC.onAdd] Adding picture with id: $id from $_pictures');
        _pictures.add(id);
      },
      onRemove: (String id) async {
        logger.d('[ImageManagerIC.onRemove] Removing picture with id: $id from $_pictures');
        final exists = _pictures.contains(id);
        assert(exists, 'Picture with id $id does not exist in the list');
        if (!exists) return;
        _pictures.removeWhere((pic) => pic == id);
        logger.d('[ImageManagerUC.onRemove] Removed picture with id: $id from $_pictures');
      },
    );
