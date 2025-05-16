import 'package:wonder/src/data/data_item.dart';
import 'package:wonder/src/data/picture_item.dart';
import 'package:wonder/src/data/value_item.dart';

class Facility extends DataItem {
  static final defaultPictures = [
    ImageFields({'slug': '1246fe_888314eeeb9a4468ab2ba15e283ecbfa~mv2.png'}),
  ];

  late List<ImageFields> _pictures;

  Facility(super.fields, super.listsOfValues) {
    if (!containsField('pictures')) {
      _pictures = defaultPictures;
      return;
    }

    _pictures = this['pictures'].map<ImageFields>((e) {
      return ImageFields(e);
    }).toList();
  }

  int get number => (this['number']).toInt();

  ValueItem get type => listsOfValues.getValue(this['type']);

  ValueItem get subtype => listsOfValues.getValue(this['subtype']);

  ValueItem get status => listsOfValues.getValue(this['status']);

  List<ImageFields> get pictures {
    return _pictures;
  }

  ImageFields get mainPicture => pictures[0];
}
