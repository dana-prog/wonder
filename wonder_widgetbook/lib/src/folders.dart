import 'package:widgetbook/widgetbook.dart';
import 'package:wonder_widgetbook/src/platform/media/app_image_uc.dart';

import 'platform/media/test_uc.dart';

class FolderNames {
  static const editors = '[Editors]';
  static const viewers = '[Viewers]';
  static const detailsPage = '[DetailsPage]';

  static const facility = '[Facility]';
  static const user = '[User]';
  static const platform = '[Platform]';
  static const authentication = '[Authentication]';

  static const media = '[Media]';
}

WidgetbookNode getFolder(String path) {
  final pathParts = path.split('/');

  WidgetbookNode folder = WidgetbookRoot(children: folders);
  for (int i = 0; i < pathParts.length; i++) {
    final childName = pathParts[i];
    final childFolder = folder.find((node) => node.name == childName);
    if (childFolder == null) {
      throw Exception('Folder not found: $childName in ${folder.path}');
    }

    folder = childFolder;
  }

  return folder;
}

final folders = [
  WidgetbookCategory(
    name: FolderNames.platform,
    children: [
      WidgetbookUseCase(name: 'AppImage', builder: appImage),
      WidgetbookUseCase(name: 'test', builder: test),
      // WidgetbookUseCase(name: 'Text', builder: test)
    ],
  ),
];
