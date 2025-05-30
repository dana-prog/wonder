import 'item.dart';
import 'item_helpers.dart';

class UserItem extends Item {
  UserItem.fromFields(super.fields)
      : assert(fields['itemType'] == 'user',
            'UserItem must be of type user and not ${fields['itemType']}');

  @override
  String get title => [
        firstName,
        middleName,
        (nickname.isNotEmpty ? '"$nickname"' : null),
        lastName,
      ].whereType<String>().join(' ');

  String get firstName => this['firstName'];

  String get lastName => this['lastName'];

  String get middleName => getFieldValue('middleName', defaultValue: '')!;

  String get nickname => getFieldValue('nickname', defaultValue: '')!;

  String get email => this['email'];

  String? get picture => getFieldValue('picture');

  @override
  void operator []=(String fieldName, dynamic fieldValue) {
    dynamic resolvedValue;
    if (fieldName == 'picture') {
      assert(fieldValue is String, 'Picture field must be a String');
      resolvedValue = isWixImageUrl(fieldValue) ? getStorageUrl(fieldValue) : fieldValue;
    } else {
      resolvedValue = fieldValue;
    }

    super[fieldName] = resolvedValue;
  }
}
