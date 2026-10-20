import 'package:flutter/material.dart';

void showAppMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

// L3 confirms the action; modifying the shared mock collection belongs to L4.
Future<void> confirmDemoRemoval(BuildContext context, String item) async {
  final ok = await confirmAction(
    context,
    title: 'Delete $item?',
    message:
        'Confirm deletion? Demo data will remain unchanged in this version.',
    confirmLabel: 'Delete',
  );
  if (!context.mounted || !ok) return;
  showAppMessage(context, 'Deletion confirmed. Demo data is unchanged.');
}

Future<bool> confirmAction(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (dialogCtx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogCtx).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(dialogCtx).colorScheme.error,
            foregroundColor: Theme.of(dialogCtx).colorScheme.onError,
          ),
          onPressed: () => Navigator.of(dialogCtx).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return ok == true;
}
