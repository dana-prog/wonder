import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/data/file_item.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/data/user_item.dart';

class WidgetbookData {
  // users by email
  static final Map<String, UserItem> users = {};
  // lists by type containing values by name (access like this: lists['facilityStatues']['construction'])
  static final Map<String, Map<String, ListValueItem>> lists = {};

  static final List<FileItem> files = [];

  static final List<FacilityItem> facilities = [];
}
