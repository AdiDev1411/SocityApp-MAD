import 'package:flutter/material.dart';
import 'auth_screen.dart'; // Import the enum from auth_screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userRole = ModalRoute.of(context)!.settings.arguments as UserRole;
    const Color primaryColor = Color(0xFF1976D2);

    return Scaffold(
      appBar: AppBar(
        title: Text(userRole == UserRole.admin ? 'Admin Dashboard' : 'Owner Portal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: userRole == UserRole.admin
              ? _buildAdminView(context, primaryColor)
              : _buildOwnerView(context, primaryColor),
        ),
      ),
    );
  }

  Widget _buildAdminView(BuildContext context, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.admin_panel_settings, size: 80, color: color),
            const SizedBox(height: 16),
            Text(
              'Admin Controls',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'sans-serif-light',
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your system from here.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Create New'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                // Navigate to the new screen
                Navigator.pushNamed(context, '/create_new');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerView(BuildContext context, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home_work_outlined, size: 80, color: color),
            const SizedBox(height: 16),
            Text(
              'Building Access',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'sans-serif-light',
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your building code to proceed.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Code',
                prefixIcon: Icon(Icons.vpn_key, color: color),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Code submitted!')),
                );
              },
              child: const Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}
