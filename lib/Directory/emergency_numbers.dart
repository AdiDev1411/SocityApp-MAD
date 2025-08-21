import 'package:flutter/material.dart';

class EmergencyNumbersScreen extends StatelessWidget {
  const EmergencyNumbersScreen({super.key});

  // A simple data model for an emergency contact
  _buildEmergencyContact(String name, String number, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.red, size: 30),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(number, style: const TextStyle(fontSize: 16)),
        trailing: IconButton(
          icon: const Icon(Icons.call),
          onPressed: () {
            // In a real app, you would use a package like 'url_launcher' to make a call
            // For now, this is a placeholder.
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Numbers'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildEmergencyContact('Police', '100', Icons.local_police_outlined),
          _buildEmergencyContact('Ambulance', '108', Icons.emergency_outlined),
          _buildEmergencyContact('Fire Brigade', '101', Icons.fire_truck_outlined),
          _buildEmergencyContact('Disaster Management', '1077', Icons.warning_amber_rounded),
          _buildEmergencyContact('Women Helpline', '1091', Icons.woman_outlined),
          _buildEmergencyContact('Child Helpline', '1098', Icons.child_care_outlined),
        ],
      ),
    );
  }
}
