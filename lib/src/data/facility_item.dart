import 'package:wonder/src/data/data_item.dart';
import 'package:wonder/src/data/item.dart';

import 'image_fields.dart';

class FacilityItem extends Item {
  static final defaultPictures = [
    ImageFields({'slug': '1246fe_888314eeeb9a4468ab2ba15e283ecbfa~mv2.png'}),
  ];

  late List<ImageFields> _pictures;

  FacilityItem.fromFields(super.fields) : super.fromFields() {
    assert(this['itemType'] == 'facility', 'FacilityItem must be of type facility');

    // TODO: check pictures implementation
    if (containsField('pictures')) {
      _pictures = this['pictures'].map<ImageFields>((fields) => ImageFields(fields)).toList();
    } else {
      _pictures = defaultPictures;
    }
  }

  FacilityItem({
    required int number,
    required String status,
    required String type,
    required String subtype,
    required String owner,
    int? roomCount,
  }) : super.fromFields({
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

  List<ImageFields> get pictures => _pictures;

  ImageFields get mainPicture => pictures[0];

  @override
  ItemType get itemType => ItemType.facility;
}
