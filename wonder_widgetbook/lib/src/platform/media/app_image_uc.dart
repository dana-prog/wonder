import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/media/app_image.dart';

import '../../utils/widgetbook_data.dart';

Widget appImage(BuildContext context) {
  final file = WidgetbookData.files.first;
  return AppImage(
    fileUrl: file['id'],
    width: file['width']?.toDouble() ?? 200,
    height: file['height']?.toDouble() ?? 200,
  );
}
