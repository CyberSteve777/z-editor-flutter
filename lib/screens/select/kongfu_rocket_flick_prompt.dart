import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:z_editor/bloc/editor/editor_cubit.dart';
import 'package:z_editor/l10n/app_localizations.dart';

EditorCubit? _tryReadEditorCubit(BuildContext context) {
  try {
    return context.read<EditorCubit>();
  } catch (_) {
    return null;
  }
}

/// When the user picks Kongfu rocket zombie, offers to add [RocketZombieFlickModuleProperties].
Future<void> maybeShowKongfuRocketFlickPrompt(
  BuildContext context,
  Iterable<String> zombieIds, {
  EditorCubit? editorCubit,
}) async {
  if (!zombieIds.contains('kongfu_rocket')) return;
  final ec = editorCubit ?? _tryReadEditorCubit(context);
  if (ec == null || ec.hasRocketZombieFlickModule) return;

  final l10n = AppLocalizations.of(context);
  final add = await showDialog<bool>(
    context: context,
    builder: (dialogCtx) => AlertDialog(
      title: Text(l10n?.kongfuRocketFlickDialogTitle ?? 'Rocket zombie'),
      content: Text(
        l10n?.kongfuRocketFlickDialogMessage ??
            'Do you want this zombie to be flicked off the lawn? The editor can add the Rocket Zombie Flick module to the level.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogCtx, false),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF4CAF50),
          ),
          child: Text(l10n?.cancel ?? 'Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogCtx, true),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            foregroundColor: Colors.white,
          ),
          child: Text(l10n?.add ?? 'Add'),
        ),
      ],
    ),
  );
  if (add == true && context.mounted) {
    (editorCubit ?? _tryReadEditorCubit(context))
        ?.addRocketZombieFlickModuleSilently();
  }
}
