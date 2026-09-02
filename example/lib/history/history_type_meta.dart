import 'package:flutter/material.dart';

import 'history_entry.dart';

/// Icon/color/label shown for a [HistoryType], kept in one place so the
/// history list and its detail sheet always agree on how a type looks.
class HistoryTypeMeta {
  final IconData icon;
  final Color color;
  final String label;

  const HistoryTypeMeta(this.icon, this.color, this.label);
}

const _meta = <HistoryType, HistoryTypeMeta>{
  HistoryType.payment:
      HistoryTypeMeta(Icons.payments_outlined, Colors.teal, 'Payment'),
  HistoryType.agreement:
      HistoryTypeMeta(Icons.handshake_outlined, Colors.indigo, 'Agreement'),
  HistoryType.refund:
      HistoryTypeMeta(Icons.undo_rounded, Colors.deepOrange, 'Refund'),
  HistoryType.refundStatus: HistoryTypeMeta(
      Icons.fact_check_outlined, Colors.purple, 'Refund status'),
};

HistoryTypeMeta metaFor(HistoryType type) => _meta[type]!;
