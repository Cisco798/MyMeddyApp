import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/appointment_tile.dart';
import '../widgets/empty_state.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Replace with Riverpod provider for appointments
    final appointments = []; // Example: ref.watch(appointmentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/add_appointment'),
          ),
        ],
      ),
      body: appointments.isEmpty
          ? EmptyState(
              message: 'No upcoming appointments',
              icon: Icons.calendar_today,
              actionLabel: 'Schedule Appointment',
              onActionPressed: () => Navigator.pushNamed(context, '/add_appointment'),
            )
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) => AppointmentTile(
                title: appointments[index].title,
                location: appointments[index].location,
                dateTime: appointments[index].dateTime,
                onTap: () => Navigator.pushNamed(
                  context,
                  '/appointment_details',
                  arguments: appointments[index].id,
                ),
              ),
            ),
    );
  }
}