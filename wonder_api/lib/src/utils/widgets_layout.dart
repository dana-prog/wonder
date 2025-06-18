import 'package:flutter/material.dart';

class WidgetsLayout extends StatelessWidget {
  static final defaultSpacing = 16.0;
  static final defaultUserImageAssetPath = 'images/default_user.png';
  static final userImageAssetPath = 'images/dana_shalev.jpg';

  final Map<String, SectionProps> sections;
  const WidgetsLayout({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: sections.entries
            .map<List<Widget>>(
              (sectionEntry) => [
                buildSectionTitle(context, sectionEntry.key),
                SizedBox(height: defaultSpacing),
                buildSectionWidgets(context, sectionEntry.value),
                SizedBox(height: defaultSpacing * 2),
              ],
            )
            .toList()
            .expand((inner) => inner)
            .toList(),
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String label) =>
      Center(child: Text(label, style: Theme.of(context).textTheme.headlineSmall));

  Widget buildSubtitle(BuildContext context, String label) =>
      Center(child: Text(label, style: Theme.of(context).textTheme.titleSmall));

  Widget buildSectionWidgets(BuildContext context, SectionProps props) {
    return GridView.count(
      crossAxisCount: props.rowWidgetCount,
      childAspectRatio: props.childAspectRatio,
      // TODO: learn about shrinkWrap, NeverScrollableScrollPhysics, SilverXXX
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: buildChildren(context, props),
    );
  }

  List<Widget> buildChildren(BuildContext context, SectionProps props) {
    if (props.widget != null) {
      // widget
      return [props.widget!];
    }

    return props.widgets!.entries
        .map(
          (entry) => Column(
            spacing: defaultSpacing,
            children: [
              // title
              buildSubtitle(context, entry.key),
              // widget
              entry.value,
            ],
          ),
        )
        .toList();
  }
}

class SectionProps {
  final Map<String, Widget>? widgets;
  final Widget? widget;
  final int rowWidgetCount;
  final double childAspectRatio;

  SectionProps({this.widgets, this.widget, this.rowWidgetCount = 3, this.childAspectRatio = 2.0})
    : assert(widgets != null || widget != null, 'Either widgets or widget must be provided'),
      assert(widgets == null || widget == null, 'Cannot provide both widgets and widget'),
      assert(rowWidgetCount > 0, 'rowWidgetCount must be greater than 0'),
      assert(childAspectRatio > 0, 'childAspectRatio must be greater than 0');
}
