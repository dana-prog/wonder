import 'package:flutter/material.dart';

class UseCasesLayout extends StatelessWidget {
  static final defaultSpacing = 16.0;
  static final defaultUserImageAssetPath = 'images/default_user.png';
  static final userImageAssetPath = 'images/dana_shalev.jpg';

  final Map<String, GridProps> sections;
  const UseCasesLayout({
    super.key,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: sections.entries
            .map<List<Widget>>((sectionEntry) => [
                  buildTitle(context, sectionEntry.key),
                  SizedBox(height: defaultSpacing),
                  buildWidgetsGrid(context, sectionEntry.value),
                  SizedBox(height: defaultSpacing * 2),
                ])
            .toList()
            .expand(
              (inner) => inner,
            )
            .toList(),
      ),
    );
  }

  Widget buildTitle(
    BuildContext context,
    String label,
  ) =>
      Center(child: Text(label, style: Theme.of(context).textTheme.headlineSmall));

  Widget buildSubtitle(
    BuildContext context,
    String label,
  ) =>
      Center(child: Text(label, style: Theme.of(context).textTheme.titleSmall));

  Widget buildWidgetsGrid(
    BuildContext context,
    GridProps props,
  ) {
    return GridView.count(
      crossAxisCount: props.rowWidgetCount,
      childAspectRatio: props.childAspectRatio,
      // TODO: learn about shrinkWrap, NeverScrollableScrollPhysics, SilverXXX
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: props.builders.entries
          .map(
            (entry) => Column(
              mainAxisSize: MainAxisSize.min,
              spacing: defaultSpacing,
              children: [
                buildSubtitle(context, entry.key),
                entry.value.call(context),
                // entry.value,
              ],
            ),
          )
          .toList(),
    );
  }
}

class GridProps {
  final Map<String, WidgetBuilder> builders;
  final int rowWidgetCount;
  final double childAspectRatio;

  GridProps({
    required this.builders,
    this.rowWidgetCount = 3,
    this.childAspectRatio = 2.0,
  });
}

abstract class All {}
