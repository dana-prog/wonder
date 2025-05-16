import 'package:flutter/material.dart';

import '../../data/facility.dart';
import '../media/app_image.dart';

class FacilityCard extends StatelessWidget {
  final Facility facility;

  FacilityCard(this.facility) : super(key: ValueKey(facility.id));

  @override
  Widget build(BuildContext context) {
    final radius = 30.0;
    return Card(
      child: ListTile(
        leading: SizedBox(
            width: radius * 2,
            height: radius * 2,
            child: ClipOval(
              child: AppImage(facility.mainPicture),
            )),
        title: getTitle(),
        subtitle: Text(facility.type.title),
        // onTap: () => navigateToItem(
        //   item.id,
        //   context,
        // ),
      ),
    );
  }

  Widget getTitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('#${facility.number}'),
      ],
    );
  }

  Widget getSubtitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('#${facility.number}'),
      ],
    );
  }
}
