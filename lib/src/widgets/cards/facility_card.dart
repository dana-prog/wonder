import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/media/WixImage.dart';

import '../../data/facility.dart';

class FacilityCard extends StatelessWidget {
  final Facility facility;

  FacilityCard(this.facility) : super(key: ValueKey(facility.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: AppImage(facility.mainPicture),
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
