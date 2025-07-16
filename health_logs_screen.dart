import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/health_log_item.dart';
import '../widgets/empty_state.dart';

class HealthLogsScreen extends ConsumerWidget {
  const HealthLogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Replace with Riverpod provider for health logs
    final healthLogs = []; // Example: ref.watch(healthLogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Health Logs')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/add_health_log'),
      ),
      body: healthLogs.isEmpty
          ? const EmptyState(
              message: 'No health logs recorded',
              icon: Icons.health_and_safety,
            )
          : RefreshIndicator(
              onRefresh: () async {
                // TODO: Implement refresh logic
                // await ref.refresh(healthLogProvider.future);
              },
              child: ListView.builder(
                itemCount: healthLogs.length,
                itemBuilder: (context, index) => HealthLogItem(
                  note: healthLogs[index].note,
                  healthRating: healthLogs[index].rating,
                  date: healthLogs[index].date,
                  onDelete: () => _deleteLog(ref, healthLogs[index].id),
                ),
              ),
            ),
    );
  }

  void _deleteLog(WidgetRef ref, String logId) {
    showDialog(
      context: ref.context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Log'),
        content: const Text('Are you sure you want to delete this health log?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete
              // ref.read(healthLogProvider.notifier).removeLog(logId);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}