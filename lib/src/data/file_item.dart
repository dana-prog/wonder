import 'item.dart';

class FileItem extends Item {
  FileItem(super.fields);

  String get name => this['name'];
}

class FolderItem extends Item {
  FolderItem(super.fields);

  String get name => this['name'];
}
