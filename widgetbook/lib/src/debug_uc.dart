import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/src/widgets/items/user/user_avatar.dart';

const _folder = 'debug';

@UseCase(name: 'unbounded_width', type: UnboundedWidth, path: _folder)
Widget unboundedWidth(BuildContext _) => UnboundedWidth();

@UseCase(name: 'not_working', type: UnboundedWidth, path: _folder)
Widget notWorking(BuildContext _) => NotWorking();

class UnboundedWidth extends StatelessWidget {
  const UnboundedWidth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // SizedBox(
      // width: double.infinity,
      // child:
      Row(children: [
        DropdownSearch<String>(),
        DropdownSearch<String>(),
        // Expanded(child: DropdownSearch<String>())
      ]),
      // ),
      // Row(children: [Text('Row2')]),
    ]);
  }
}

class NotWorking extends StatelessWidget {
  final defaultSpacing = 15.0;
  final mainLabelWidth = 100.0;

  const NotWorking({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 20, children: [
      CircleAvatar(
        child: Image.asset(
          'images/default_user.png',
          package: 'assets',
        ),
      ),
      CircleAvatar(
        radius: 10,
        child: Image.asset(
          'images/default_user.png',
          package: 'assets',
        ),
      ),
      UserAvatar(item: null),
    ]);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return buildGrid(
  //     [
  //       UseCaseProps(
  //         label: Text('Use Case 1'),
  //         widgets: List.generate(1, (_) => userChip(context)),
  //       ),
  //       UseCaseProps(
  //         label: Text('Use Case 2'),
  //         widgets: List.generate(2, (_) => userChip(context)),
  //       ),
  //       UseCaseProps(
  //         label: Text('Use Case 3'),
  //         widgets: List.generate(3, (_) => userChip(context)),
  //       ),
  //       UseCaseProps(
  //         label: Text('Use Case 4'),
  //         widgets: List.generate(4, (_) => userChip(context)),
  //       ),
  //       UseCaseProps(
  //         label: Text('Use Case 5'),
  //         widgets: List.generate(5, (_) => userChip(context)),
  //       ),
  //       UseCaseProps(
  //         label: Text('Use Case 6'),
  //         widgets: List.generate(6, (_) => userChip(context)),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget buildGrid(List<UseCaseProps> useCasesProps) {
  //   final count = 1;
  //   final gridViewItems = useCasesProps.fold<List<Widget>>(
  //     [],
  //     (preValue, useCaseProps) {
  //       final placeholdersCount = 3 - (useCaseProps.widgets.length + 1) % 3;
  //       logger.d(
  //           '[buildGrid] widgets.length: ${useCaseProps.widgets.length} placeholdersCount: $placeholdersCount');
  //       return [
  //         ...preValue,
  //         useCaseProps.label,
  //         ...useCaseProps.widgets,
  //         ...List.generate(placeholdersCount, (_) => SizedBox.shrink()),
  //       ];
  //     },
  //   );
  //
  //   return GridView.count(
  //     crossAxisCount: 3,
  //     // shrinkWrap: true,
  //     // physics: NeverScrollableScrollPhysics(),
  //     children: gridViewItems,
  //   );
  // }

// @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('MainLabel'),
  //           SizedBox(width: 16),
  //           Expanded(
  //             child: SingleChildScrollView(
  //               child: GridView.count(
  //                 crossAxisCount: 2,
  //                 shrinkWrap: true,
  //                 physics: NeverScrollableScrollPhysics(),
  //                 children: List.generate(4, (index) {
  //                   return Column(
  //                     spacing: defaultSpacing,
  //                     children: [
  //                       Text('Label'),
  //                       Center(child: Text('Item ${index + 1}')),
  //                     ],
  //                   );
  //                   // return Card(
  //                   //   child: Center(child: Text('Item $index')),
  //                   // );
  //                 }),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('MainLabel'),
  //           SizedBox(width: 16),
  //           Expanded(
  //             child: SingleChildScrollView(
  //               child: GridView.count(
  //                 crossAxisCount: 2,
  //                 shrinkWrap: true,
  //                 physics: NeverScrollableScrollPhysics(),
  //                 children: List.generate(24, (index) {
  //                   return Column(
  //                     spacing: defaultSpacing,
  //                     children: [
  //                       Text('Label'),
  //                       Center(child: Text('Item ${index + 1}')),
  //                     ],
  //                   );
  //                   // return Card(
  //                   //   child: Center(child: Text('Item $index')),
  //                   // );
  //                 }),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  //   // Row 2
  //   // Row(
  //   //   crossAxisAlignment: CrossAxisAlignment.start,
  //   //   children: [
  //   //     Text('MainLabel1'),
  //   //     SizedBox(width: 16),
  //   //     Expanded(
  //   //       child: Column(
  //   //         crossAxisAlignment: CrossAxisAlignment.start,
  //   //         children: [
  //   //           Text('Label'),
  //   //           GridView.count(
  //   //             crossAxisCount: 3,
  //   //             shrinkWrap: true,
  //   //             // TODO: learn about shrinkWrap, NeverScrollableScrollPhysics, SilverXXX
  //   //             physics: NeverScrollableScrollPhysics(),
  //   //             children: List.generate(2, (index) {
  //   //               return Card(
  //   //                 child: Center(child: Text('Item $index')),
  //   //               );
  //   //             }),
  //   //           ),
  //   //         ],
  //   //       ),
  //   //     ),
  //   //   ],
  //   // ),
  //   // ],
  //   // );
  // }
}

abstract class All {}
