import 'package:flutter/material.dart';

import 'history_detail_sheet.dart';
import 'history_entry.dart';
import 'history_store.dart';
import 'history_type_meta.dart';
import 'prefill_request.dart';

/// Lists every saved [HistoryEntry], newest first. Tapping one opens its
/// details; picking a follow-up action there pops this page with the
/// resulting [PrefillRequest] so the caller (home screen) can act on it.
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _store = HistoryStore();
  late Future<List<HistoryEntry>> _entries;

  @override
  void initState() {
    super.initState();
    _entries = _store.loadAll();
  }

  Future<void> _reload() async {
    setState(() => _entries = _store.loadAll());
    await _entries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Clear all',
            onPressed: () async {
              await _store.clear();
              await _reload();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<HistoryEntry>>(
        future: _entries,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final entries = snapshot.data!;
          if (entries.isEmpty) {
            return const Center(
              child: Text('No saved payments, agreements or refunds yet.'),
            );
          }
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) => _HistoryTile(
                entry: entries[index],
                onDeleted: _reload,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final HistoryEntry entry;
  final VoidCallback onDeleted;

  const _HistoryTile({required this.entry, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    final meta = metaFor(entry.type);

    return Dismissible(
      key: ValueKey(entry.id),
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete_outline),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) async {
        await HistoryStore().remove(entry.id);
        onDeleted();
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: meta.color.withValues(alpha: 0.15),
          child: Icon(meta.icon, color: meta.color),
        ),
        title: Text(entry.title),
        subtitle: Text(meta.label),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          final prefill = await showHistoryDetailsSheet(context, entry);
          if (prefill != null && context.mounted) {
            Navigator.of(context).pop<PrefillRequest>(prefill);
          }
        },
      ),
    );
  }
}
