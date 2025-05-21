import 'package:flutter/material.dart';

import '../../data/facility_item.dart';

class FacilityPreview extends StatelessWidget {
  final FacilityItem facility;

  const FacilityPreview(this.facility);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Implement Facility Preview',
    );
    // return FacilityForm(facility, true);
  }
}
