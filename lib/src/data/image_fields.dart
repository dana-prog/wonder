import 'package:wonder/src/data/item.dart';

const wixMediaUrlPrefix = 'https://static.wixstatic.com/media';

class ImageFields extends Fields {
  ImageFields(super.fields);

  ImageFields.fromWixMediaUrl(String wixImageUrl)
      : super({
          'url': _wixImageUrlToPublicUrl(wixImageUrl),
        });

  String get url {
    if (containsField('url')) {
      return this['url'];
    }

    final suffix = containsField('slug') ? this['slug'] : this['id'];
    return '$wixMediaUrlPrefix/$suffix';
  }
}

String _wixImageUrlToPublicUrl(String wixImageUrl) {
  // return 'https://static.wixstatic.com/media/1246fe_b56c192a93b243c9a59a37ba02f26aee~mv2.jpg';
  final match = RegExp(r'wix:image://v1/([^/]+)').firstMatch(wixImageUrl);
  if (match != null) {
    final mediaId = match.group(1);
    return '$wixMediaUrlPrefix/$mediaId';
  }
  throw FormatException('Invalid Wix image URL');
}
