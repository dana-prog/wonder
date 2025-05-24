import 'item.dart';
import 'item_helpers.dart';

class UserItem extends Item {
  static final _defaultPicture =
      '$mediaPublicUrlPrefix/1246fe_7609a78c62784e4788f3fb2c6a65fb95~mv2.png';

  UserItem.fromFields(super.fields)
      : assert(fields['itemType'] == 'user',
            'UserItem must be of type user and not ${fields['itemType']}');

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

  String get picture => getFieldValue('picture') ?? _defaultPicture;

  @override
  void operator []=(String fieldName, dynamic fieldValue) {
    if (fieldName != 'picture') {
      super[fieldName] = fieldValue;
      return;
    }

    super[fieldName] = (fieldValue is String) ? fieldValue : getStorageUrl(fieldValue);
  }
}
