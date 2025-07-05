import 'package:flutter/material.dart';
import 'package:wonder/src/storage/file_storage_plugin.dart';
import 'package:wonder/src/widgets/media/image_manager.dart';

import '../../utils/widgetbook_data.dart';

final _pictures = WidgetbookData.files.getRange(0, 4).map<String>((file) => file.id).toList();

final fileContext = FileContext(
  itemType: 'facility',
  itemId: WidgetbookData.facilities[0].id,
  fieldName: 'pictures',
);

Widget imageManager(BuildContext context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ImageManager(
          fileUrls: _pictures,
          fileContext: fileContext,
          onAdd: (String id) async {
            setState(() => _pictures.add(id));
          },
          onRemove: (String id) async {
            final exists = _pictures.contains(id);
            assert(exists, 'Picture with id $id does not exist in the list');
            if (!exists) return;
            setState(() => _pictures.removeWhere((pic) => pic == id));
          },
        );
      },
    );
