import 'package:flutter/material.dart';

class Poll {
  final String question;
  final List<String> options;
  final String status; // "Ongoing", "Closed"
  String? selectedOption;

  Poll({required this.question, required this.options, required this.status, this.selectedOption});
}

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  // Dummy data is now part of the state to allow modifications
  final List<Poll> _polls = [
    Poll(question: 'Should we repaint the building exterior this year?', options: ['Yes', 'No', 'Postpone to next year'], status: 'Ongoing'),
    Poll(question: 'Select a vendor for security services.', options: ['Vendor A', 'Vendor B', 'Vendor C'], status: 'Closed', selectedOption: 'Vendor A'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting & Polls'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _polls.length,
        itemBuilder: (context, index) {
          final poll = _polls[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(poll.question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  // The options are now interactive
                  ...poll.options.map((option) => RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: poll.selectedOption,
                    // Only allow changing the selection for ongoing polls
                    onChanged: poll.status == 'Ongoing'
                        ? (value) {
                      setState(() {
                        poll.selectedOption = value;
                      });
                    }
                        : null, // Disable for closed polls
                  )),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Status: ${poll.status}',
                      style: TextStyle(
                        color: poll.status == 'Ongoing' ? Colors.green : Colors.red,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
