import 'package:flutter/material.dart' hide Chip;
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/src/widgets/platform/chip.dart';
import 'package:wonder_widgetbook/src/folders.dart';

const _folder = '${FolderNames.platform}/[chip]';

// TODO: add knobs for label, labelStyle, backgroundColor, etc.
@UseCase(name: 'Default', type: Chip, path: _folder)
Chip defaultChip(BuildContext context) => const Chip(label: 'Default');
