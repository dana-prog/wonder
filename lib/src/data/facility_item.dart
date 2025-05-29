import 'package:wonder/src/data/data_item.dart';
import 'package:wonder/src/data/item.dart';
import 'package:wonder/src/data/item_helpers.dart';

class FacilityItem extends Item {
  static final _defaultPictures = [
    '$mediaPublicUrlPrefix/1246fe_888314eeeb9a4468ab2ba15e283ecbfa~mv2.png'
  ];

  FacilityItem.fromFields(Map<String, dynamic> fields) : super({'itemType': 'facility', ...fields});

  FacilityItem({
    required int number,
    required String status,
    required String type,
    required String subtype,
    required String owner,
    int? roomCount,
  }) : this.fromFields({
          'dataCollectionId': ItemType.facility.pluralName,
          'number': number,
          'status': status,
          'type': type,
          'subtype': subtype,
          'owner': owner,
          'roomCount': roomCount,
        });

  int get number => (this['number']).toInt();

  String? get owner => containsField('owner') ? this['owner'] : null;

  String get type => this['type'];

  String get subtype => this['subtype'];

  String get status => this['status'];

  int get roomCount => (this['roomCount']).toInt();

  List<String> get pictures =>
      getFieldValue<List<String>>('pictures', defaultValue: _defaultPictures)!;

  String get mainPicture => pictures[0];

  // TODO: remove hard codes villa or separate to a itemType
  @override
  String get title => 'Villa #$number';

  @override
  void operator []=(String fieldName, dynamic fieldValue) {
    if (fieldName != 'pictures') {
      super[fieldName] = fieldValue;
      return;
    }

    super[fieldName] = fieldValue
        .map((pic) {
          return (pic is String) ? pic : getStorageUrl(pic['src']);
        })
        .cast<String>()
        .toList();
  }
}
