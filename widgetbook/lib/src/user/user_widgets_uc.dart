import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/src/providers/users_provider.dart';
import 'package:wonder/src/widgets/items/user/initials_avatar.dart';
import 'package:wonder/src/widgets/items/user/user_avatar.dart';
import 'package:wonder/src/widgets/items/user/user_chip.dart';
import 'package:wonder/src/widgets/items/user/users_dropdown.dart';

import '../folders.dart';

const _folder = FolderNames.user;
const _userId = 'dana_shalev';
const _userIdNoPic = 'no_pic';
const _userIdLongName = 'verylongfirstname_verylonglastname';

@UseCase(name: 'width = 25', type: InitialsAvatar, path: _folder)
Widget initialsAvatar25(BuildContext _) =>
    Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider(_userId));

      return SizedBox(width: 25, child: InitialsAvatar(user: user));
    });

@UseCase(name: 'width = 50', type: InitialsAvatar, path: _folder)
Widget initialsAvatar50(BuildContext _) =>
    Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider(_userId));

      return SizedBox(width: 50, child: InitialsAvatar(user: user));
    });

@UseCase(name: 'default', type: UserAvatar, path: _folder)
Widget userAvatar(BuildContext _) => Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider(_userId));

      return SizedBox(height: 25, width: 25, child: UserAvatar(item: user));
    });

@UseCase(name: 'no pic', type: UserAvatar, path: _folder)
Widget userAvatarNoPic(BuildContext _) =>
    Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider(_userIdNoPic));

      return SizedBox(height: 25, width: 25, child: UserAvatar(item: user));
    });

@UseCase(name: 'no user', type: UserAvatar, path: _folder)
Widget userAvatarNoUser(BuildContext _) =>
    SizedBox(height: 25, width: 25, child: UserAvatar(item: null));

@UseCase(name: 'size = 25', type: UserAvatar, path: _folder)
Widget userAvatar25(BuildContext _) => Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider(_userId));

      return SizedBox(height: 25, width: 25, child: UserAvatar(item: user));
    });

@UseCase(name: 'size = 50', type: UserAvatar, path: _folder)
Widget userAvatar50(BuildContext _) => Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider(_userId));

      return SizedBox(height: 50, width: 50, child: UserAvatar(item: user));
    });

@UseCase(name: 'default', type: UserChip, path: _folder)
Widget userChip(BuildContext _) => Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider(_userId));

      return UserChip(item: user);
    });

@UseCase(name: 'no pic', type: UserChip, path: _folder)
Widget userChipNoPic(BuildContext _) => Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider(_userIdNoPic));

      return UserChip(item: user);
    });

@UseCase(name: 'no user', type: UserChip, path: _folder)
Widget userChipNoUser(BuildContext _) => UserChip(item: null);

@UseCase(name: 'overflow', type: UserChip, path: _folder)
Widget userChipOverflow(BuildContext _) =>
    Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider(_userIdLongName));

      return UserChip(item: user);
    });

@UseCase(name: 'default', type: UsersDropdownConsumer, path: _folder)
Widget usersDropdown(BuildContext _) => UsersDropdownConsumer(selectedId: _userId);

@UseCase(name: 'no pic', type: UsersDropdownConsumer, path: _folder)
Widget usersDropdownNoPic(BuildContext _) => UsersDropdownConsumer(selectedId: _userIdNoPic);

@UseCase(name: 'no user', type: UsersDropdownConsumer, path: _folder)
Widget usersDropdownNoUser(BuildContext _) => UsersDropdownConsumer(selectedId: null);

@UseCase(name: 'overflow', type: UsersDropdownConsumer, path: _folder)
Widget usersDropdownOverflow(BuildContext _) => UsersDropdownConsumer(selectedId: _userIdLongName);

@UseCase(name: 'all', type: All, path: _folder)
Widget all(BuildContext _) => All(sections: getSections());

List<SectionProps> getSections() => [
      // InitialsAvatar
      SectionProps(
        label: 'InitialsAvatar',
        builders: {
          'width = 25': initialsAvatar25,
          'width = 50': initialsAvatar50,
        },
      ),
      // UserAvatar
      SectionProps(
        label: 'UserAvatar',
        builders: {
          'default': userAvatar,
          'no pic': userAvatarNoPic,
          'no user': userAvatarNoUser,
          'size = 25': userAvatar25,
          'size = 50': userAvatar50,
        },
      ),
      // UserChip
      SectionProps(
        label: 'UserChip',
        builders: {
          'default': userChip,
          'no pic': userChipNoPic,
          'no user': userChipNoUser,
          'overflow': userChipOverflow,
        },
      ),
      // UsersDropdown
      SectionProps(
        label: 'UsersDropdown',
        builders: {
          'default': usersDropdown,
          'no pic': usersDropdownNoPic,
          'no user': usersDropdownNoUser,
          'overflow': usersDropdownOverflow,
        },
        childAspectRatio: 1.5,
      )
    ];

class All extends StatelessWidget {
  static final defaultSpacing = 16.0;
  static final defaultUserImageAssetPath = 'images/default_user.png';
  static final userImageAssetPath = 'images/dana_shalev.jpg';

  final List<SectionProps> sections;
  const All({
    super.key,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: sections
          .map(
            (section) => buildWidgetSection(section: section, context: context),
          )
          .toList(),
    );
  }

  Widget buildWidgetSection({
    required BuildContext context,
    required SectionProps section,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor)),
      child: Column(
        spacing: defaultSpacing,
        children: [
          Text(section.label, style: Theme.of(context).textTheme.titleLarge),
          GridView.count(
            crossAxisCount: section.rowWidgetCount,
            childAspectRatio: section.childAspectRatio,
            // TODO: learn about shrinkWrap, NeverScrollableScrollPhysics, SilverXXX
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: section.builders.entries
                .map(
                  (entry) => Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: defaultSpacing,
                    children: [
                      Text(entry.key, style: TextStyle(fontWeight: FontWeight.w500)),
                      entry.value.call(context),
                      // entry.value,
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class SectionProps {
  final String label;
  final Map<String, WidgetBuilder> builders;
  final int rowWidgetCount;
  final double childAspectRatio;

  SectionProps({
    required this.label,
    required this.builders,
    this.rowWidgetCount = 3,
    this.childAspectRatio = 2.0,
  });
}
