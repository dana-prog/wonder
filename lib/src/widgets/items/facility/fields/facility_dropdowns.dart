import 'package:wonder/src/widgets/items/list_value/list_values_dropdown.dart';

class FacilityTypeDropdown extends ListValuesDropdownConsumer {
  const FacilityTypeDropdown({
    super.key,
    super.selectedId,
    super.onChanged,
  }) : super(listType: 'facilityType');
}

class FacilitySubtypeDropdown extends ListValuesDropdownConsumer {
  const FacilitySubtypeDropdown({
    super.key,
    super.selectedId,
    super.onChanged,
  }) : super(listType: 'facilitySubtype');
}

class FacilityStatusDropdown extends ListValuesDropdownConsumer {
  const FacilityStatusDropdown({
    super.key,
    super.selectedId,
    super.onChanged,
  }) : super(listType: 'facilityStatus');
}
