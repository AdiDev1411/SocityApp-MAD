import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'wing_config_screen.dart';
import 'wing_details_screen.dart';

class SetupWingsScreen extends StatefulWidget {
  const SetupWingsScreen({super.key});

  @override
  State<SetupWingsScreen> createState() => _SetupWingsScreenState();
}

class _SetupWingsScreenState extends State<SetupWingsScreen> {
  // This map now stores the saved data for each wing.
  final Map<String, List<FlatInfo>> _wingsData = {};
  final Set<String> _completedWings = {};

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String userName = args['userName'];
    final int numberOfWings = args['totalWings'];
    final bool allWingsCompleted = _completedWings.length == numberOfWings && numberOfWings > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Wings'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Setup all your blocks and you will be on admin dashboard screen.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            if (numberOfWings > 0)
              ...List.generate(numberOfWings, (index) {
                String wingLetter = String.fromCharCode('A'.codeUnitAt(0) + index);
                String wingTitle = 'Setup $wingLetter';
                bool isCompleted = _completedWings.contains(wingTitle);
                return _buildSetupButton(context, wingTitle, isCompleted, wingLetter);
              })
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No wings to set up.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
              ),
            const Spacer(),
            if (allWingsCompleted)
              ElevatedButton(
                onPressed: () {
                  final joiningCode = _generateJoiningCode();
                  _showJoiningCodeDialog(context, joiningCode, userName);
                },
                child: const Text('Done'),
              )
            else
              _buildContactUsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupButton(BuildContext context, String title, bool isCompleted, String wingLetter) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        onPressed: () async {
          dynamic result;
          if (isCompleted) {
            // If already completed, go directly to the details screen to edit.
            result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WingDetailsScreen(
                  initialFlats: _wingsData[wingLetter], // Pass the saved data
                ),
              ),
            );
          } else {
            // If it's the first time, go to the configuration screen.
            result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WingConfigScreen(wingName: wingLetter),
              ),
            );
          }

          // When a result is returned, update the state.
          if (result != null && result is List<FlatInfo>) {
            setState(() {
              _wingsData[wingLetter] = result;
              _completedWings.add(title);
            });
          }
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: BorderSide(color: isCompleted ? Colors.green : Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.normal),
              ),
            ),
            Icon(
              isCompleted ? Icons.check_circle : Icons.error_outline,
              color: isCompleted ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  String _generateJoiningCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        7, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  void _showJoiningCodeDialog(BuildContext context, String code, String userName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Setup Complete!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Here is the unique joining code for your building:', textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  code,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.copy, size: 16),
                label: const Text('Copy Code'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Code copied to clipboard!')),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Finish'),
              onPressed: () {
                Navigator.pop(context);
                final dashboardArgs = {
                  'userName': userName,
                  'joiningCode': code,
                  'wingsData': _wingsData,
                };
                Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false, arguments: dashboardArgs);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactUsCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Need a custom number format or have questions? Reach out to us for assistance!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact Us button pressed!')),
                );
              },
              child: const Text('Contact us'),
            ),
          ],
        ),
      ),
    );
  }
}
