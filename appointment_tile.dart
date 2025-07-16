// lib/widgets/appointment_tile.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentTile extends StatelessWidget {
  final String title;
  final String location;
  final DateTime dateTime;
  final String? doctorName;
  final String? notes;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Color? tileColor;
  final bool isPastAppointment;

  const AppointmentTile({
    Key? key,
    required this.title,
    required this.location,
    required this.dateTime,
    this.doctorName,
    this.notes,
    this.onTap,
    this.onDelete,
    this.tileColor,
    this.isPastAppointment = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final isToday = dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      color: tileColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20.0,
                    color: isPastAppointment
                        ? Colors.grey
                        : theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isPastAppointment ? Colors.grey : null,
                      ),
                    ),
                  ),
                  if (onDelete != null)
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[400],
                        size: 20.0,
                      ),
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
              const SizedBox(height: 8.0),
              if (doctorName != null) _buildInfoRow(Icons.person, doctorName!),
              _buildInfoRow(Icons.location_on, location),
              _buildInfoRow(
                Icons.access_time,
                '${isToday ? 'Today' : DateFormat('MMM d, y').format(dateTime)} • ${DateFormat('h:mm a').format(dateTime)}',
              ),
              if (notes != null && notes!.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                Text(
                  notes!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: isPastAppointment ? Colors.grey : null,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16.0,
            color: isPastAppointment ? Colors.grey : null,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                color: isPastAppointment ? Colors.grey : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}