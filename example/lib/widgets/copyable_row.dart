import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A labeled value with a copy-to-clipboard action, used anywhere the demo
/// shows an ID or test credential the user is meant to reuse elsewhere.
class CopyableRow extends StatelessWidget {
  final String label;
  final String value;

  const CopyableRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(label, style: const TextStyle(fontSize: 12)),
      subtitle: SelectableText(value),
      trailing: IconButton(
        icon: const Icon(Icons.copy, size: 18),
        tooltip: 'Copy',
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: value));
          if (context.mounted) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('Copied $label')));
          }
        },
      ),
    );
  }
}
