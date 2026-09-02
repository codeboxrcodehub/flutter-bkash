import 'package:flutter/material.dart';

import '../payment_flow.dart';
import '../widgets/copyable_row.dart';
import 'history_entry.dart';
import 'history_type_meta.dart';
import 'prefill_request.dart';

/// Shows every field of [entry] with a per-row copy button, plus whichever
/// follow-up action makes sense for its type (pay-with-agreement / refund /
/// check-status). Returns the [PrefillRequest] if the user picks one, or
/// null if they just closed the sheet.
Future<PrefillRequest?> showHistoryDetailsSheet(
  BuildContext context,
  HistoryEntry entry,
) {
  return showModalBottomSheet<PrefillRequest>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => _HistoryDetailSheet(entry: entry),
  );
}

class _HistoryDetailSheet extends StatelessWidget {
  final HistoryEntry entry;

  const _HistoryDetailSheet({required this.entry});

  @override
  Widget build(BuildContext context) {
    final meta = metaFor(entry.type);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: meta.color.withValues(alpha: 0.15),
                child: Icon(meta.icon, color: meta.color),
              ),
              title: Text(entry.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_formatTimestamp(entry.savedAt)),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: entry.details.entries
                    .map((field) => CopyableRow(
                          label: field.key,
                          value: field.value,
                        ))
                    .toList(),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildActionButton(context),
            ),
          ],
        );
      },
    );
  }

  /// The one follow-up action worth offering for this entry's type — or
  /// nothing, for a refund-status entry (it's already a terminal lookup).
  Widget _buildActionButton(BuildContext context) {
    switch (entry.type) {
      case HistoryType.agreement:
        return FilledButton.icon(
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Pay with this agreement'),
          onPressed: () => Navigator.of(context).pop(PrefillRequest(
            flow: PaymentFlow.payWithAgreement,
            agreementId: entry.agreementId,
          )),
        );
      case HistoryType.payment:
        return FilledButton.icon(
          icon: const Icon(Icons.undo_rounded),
          label: const Text('Refund this'),
          onPressed: () => Navigator.of(context).pop(PrefillRequest(
            flow: PaymentFlow.refund,
            paymentId: entry.paymentId,
            trxId: entry.trxId,
          )),
        );
      case HistoryType.refund:
        return FilledButton.icon(
          icon: const Icon(Icons.fact_check_outlined),
          label: const Text('Check refund status'),
          onPressed: () => Navigator.of(context).pop(PrefillRequest(
            flow: PaymentFlow.refundStatus,
            paymentId: entry.paymentId,
            trxId: entry.trxId,
          )),
        );
      case HistoryType.refundStatus:
        return OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        );
    }
  }

  String _formatTimestamp(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${dt.year}-${two(dt.month)}-${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
  }
}
