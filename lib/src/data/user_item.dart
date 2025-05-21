import 'package:wonder/src/data/data_item.dart';

import 'image_fields.dart';

class UserItem extends DataItem {
  static final _defaultPicture = ImageFields({'slug': '1246fe_7609a78c62784e4788f3fb2c6a65fb95~mv2.png'});
  late ImageFields _picture;

  UserItem.fromDataCollection(super.fields) : super.fromDataCollection() {
    assert(dataItemType == DataItemType.user, 'UserItem must be of type user');

    _picture = containsField('picture') ? ImageFields.fromWixMediaUrl(this['picture']) : _defaultPicture;
  }

  String get title => [
        firstName,
        middleName,
        (nickname.isNotEmpty ? '"$nickname"' : null),
        lastName,
      ].whereType<String>().join(' ');

  String get firstName => this['firstName'];

  String get lastName => this['lastName'];

  String get middleName => containsField('middleName') ? this['middleName'] : '';

  String get nickname => containsField('nickname') ? this['nickname'] : '';

  String get email => this['email'];

  ImageFields get picture => _picture;

  @override
  DataItemType get dataItemType => DataItemType.user;
}
