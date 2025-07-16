import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HealthLogItem extends StatelessWidget {
  final String note;
  final double healthRating;
  final DateTime date;
  final VoidCallback? onDelete;

  const HealthLogItem({
    Key? key,
    required this.note,
    required this.healthRating,
    required this.date,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRatingColor(healthRating),
          child: Text(
            healthRating.toStringAsFixed(1),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(note),
        subtitle: Text(DateFormat.yMMMd().format(date)),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating < 3.0) return Colors.red;
    if (rating < 7.0) return Colors.orange;
    return Colors.green;
  }
}