import 'package:flutter_riverpod/flutter_riverpod.dart';

class HealthLog {
  final String id;
  final DateTime date;
  final String note;
  final double rating;

  HealthLog({
    required this.id,
    required this.date,
    required this.note,
    required this.rating,
  });
}

class HealthLogNotifier extends StateNotifier<List<HealthLog>> {
  HealthLogNotifier() : super([]);

  void addLog(HealthLog log) {
    state = [...state, log];
  }

  void removeLog(String id) {
    state = state.where((log) => log.id != id).toList();
  }
}

final healthLogProvider = StateNotifierProvider<HealthLogNotifier, List<HealthLog>>((ref) {
  return HealthLogNotifier();
});