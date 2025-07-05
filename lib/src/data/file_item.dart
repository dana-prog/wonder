import 'item.dart';

class FileItem extends Item {
  FileItem.fromFields(super.fields);

  String get name => this['fileName'];

  @override
  String get title => name;
}

class FolderItem extends Item {
  FolderItem(super.fields);

  String get name => this['folderName'] ?? 'folderName field is not set';

  @override
  String get title => name;
}
