import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicationCard extends StatelessWidget {
  final String name;
  final String dosage;
  final DateTime nextDoseTime;
  final VoidCallback? onTap;

  const MedicationCard({
    Key? key,
    required this.name,
    required this.dosage,
    required this.nextDoseTime,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Dosage: $dosage',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16.0),
                  const SizedBox(width: 4.0),
                  Text(
                    'Next dose: ${DateFormat('h:mm a').format(nextDoseTime)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}