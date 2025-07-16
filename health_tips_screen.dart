import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/health_api_service.dart';

final healthTipsProvider = FutureProvider<List<String>>((ref) async {
  final apiService = HealthApiService();
  return await apiService.fetchHealthTips();
});

class HealthTipsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthTipsAsync = ref.watch(healthTipsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Health Tips')),
      body: healthTipsAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (tips) => ListView.builder(
          itemCount: tips.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(tips[index]),
          ),
        ),
      ),
    );
  }
}