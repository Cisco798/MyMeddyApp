import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/medication_card.dart';
import '../widgets/empty_state.dart';

// 1. Medication Model
class Medication {
  final String id;
  final String name;
  final String dosage;
  final DateTime nextDoseTime;
  final String frequency;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.nextDoseTime,
    required this.frequency,
  });

  Medication copyWith({
    String? id,
    String? name,
    String? dosage,
    DateTime? nextDoseTime,
    String? frequency,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      nextDoseTime: nextDoseTime ?? this.nextDoseTime,
      frequency: frequency ?? this.frequency,
    );
  }
}

// 2. Riverpod State Notifier
class MedicationNotifier extends StateNotifier<List<Medication>> {
  MedicationNotifier() : super([]);

  void addMedication(Medication medication) {
    state = [...state, medication];
  }

  void updateMedication(String id, Medication updatedMedication) {
    state = state.map((med) => med.id == id ? updatedMedication : med).toList();
  }

  void deleteMedication(String id) {
    state = state.where((med) => med.id != id).toList();
  }
}

// 3. Provider Declaration
final medicationProvider = StateNotifierProvider<MedicationNotifier, List<Medication>>((ref) {
  return MedicationNotifier();
});

// 4. Main Screen
class MedicationScheduleScreen extends ConsumerWidget {
  const MedicationScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medications = ref.watch(medicationProvider);
    final medicationNotifier = ref.read(medicationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToAddMedication(context),
          ),
        ],
      ),
      body: medications.isEmpty
          ? EmptyState(
              message: 'No medications scheduled',
              icon: Icons.medication,
              actionLabel: 'Add Medication',
              onActionPressed: () => _navigateToAddMedication(context),
            )
          : RefreshIndicator(
              onRefresh: () async {
                // Could add refresh logic here if pulling from API
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  final medication = medications[index];
                  return Dismissible(
                    key: Key(medication.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) => _deleteMedication(
                      context,
                      medicationNotifier,
                      medication.id,
                    ),
                    child: MedicationCard(
                      name: medication.name,
                      dosage: medication.dosage,
                      nextDoseTime: medication.nextDoseTime,
                      onTap: () => _navigateToDetails(context, medication),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Future<void> _navigateToAddMedication(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/add_medication');
    if (result == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medication added successfully')),
      );
    }
  }

  Future<void> _navigateToDetails(BuildContext context, Medication medication) async {
    final result = await Navigator.pushNamed(
      context,
      '/medication_details',
      arguments: medication,
    );

    if (result == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medication updated successfully')),
      );
    }
  }

  void _deleteMedication(
    BuildContext context,
    MedicationNotifier notifier,
    String id,
  ) {
    notifier.deleteMedication(id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Medication deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Implement undo functionality if needed
            },
          ),
        ),
      );
    }
  }
}