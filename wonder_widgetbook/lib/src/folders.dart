import 'package:widgetbook/widgetbook.dart';
import 'package:wonder_widgetbook/src/platform/media/app_image_uc.dart';
import 'package:wonder_widgetbook/src/theme/theme_playground.dart';

import 'items/facility/facility_details_page_uc.dart';
import 'platform/media/image_manager_uc.dart';

class FolderNames {
  static const editors = '[Editors]';
  static const viewers = '[Viewers]';
  static const detailsPage = '[DetailsPage]';

  static const facility = 'Facility';
  static const user = '[User]';
  static const platform = 'platform';
  static const authentication = '[Authentication]';

  static const media = 'media';
  static const items = 'items';
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
  WidgetbookPackage(
    name: FolderNames.platform,
    children: [
      WidgetbookPackage(name: FolderNames.media, children: [
        WidgetbookLeafComponent(
          name: 'AppImage',
          useCase: WidgetbookUseCase(name: 'AppImage', builder: appImage),
        ),
        WidgetbookLeafComponent(
          name: 'ImageManager',
          useCase: WidgetbookUseCase(name: 'ImageManager', builder: imageManager),
        ),
      ]),
    ],
  ),
  WidgetbookPackage(
    name: FolderNames.items,
    children: [
      WidgetbookPackage(
        name: FolderNames.facility,
        children: [
          // WidgetbookLeafComponent(
          //   name: 'FacilityCard',
          //   useCase: WidgetbookUseCase(name: 'FacilityCard', builder: facilityCard),
          // ),
          WidgetbookComponent(
            name: 'FacilityDetailsPage',
            useCases: [
              WidgetbookUseCase(name: 'Edit', builder: editFacility),
              WidgetbookUseCase(name: 'New', builder: newFacility),
            ],
          ),
        ],
      ),
    ],
  ),
  WidgetbookFolder(name: 'Theme', children: [
    themePlayground,
  ]),
];
