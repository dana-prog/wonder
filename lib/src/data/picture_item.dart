import 'package:wonder/src/data/item.dart';

const wixMediaUrlPrefix = 'https://static.wixstatic.com/media';

class ImageFields extends Fields {
  ImageFields(super.fields);

  String get url => '$wixMediaUrlPrefix/${this['slug']}';
}
