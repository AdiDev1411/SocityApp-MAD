import 'package:flutter/material.dart';

class Suggestion {
  final String text;
  final String submittedBy;

  Suggestion({required this.text, required this.submittedBy});
}

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  // Dummy data is now part of the state
  final List<Suggestion> _suggestions = [
    Suggestion(text: 'We should start a composting pit for wet waste.', submittedBy: 'A-102'),
    Suggestion(text: 'Can we have more seating in the society garden?', submittedBy: 'C-201'),
    Suggestion(text: 'The gym equipment needs servicing.', submittedBy: 'B-302'),
  ];

  // Function to show the dialog for adding a new suggestion
  void _showAddSuggestionDialog() {
    final TextEditingController suggestionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a Suggestion'),
          content: TextField(
            controller: suggestionController,
            decoration: const InputDecoration(hintText: "Enter your suggestion here"),
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                if (suggestionController.text.isNotEmpty) {
                  setState(() {
                    // Add the new suggestion to the list (with a dummy flat number)
                    _suggestions.add(Suggestion(
                      text: suggestionController.text,
                      submittedBy: 'You',
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggestions'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestions[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              leading: const Icon(Icons.lightbulb_outline),
              title: Text(suggestion.text),
              subtitle: Text('From: Flat ${suggestion.submittedBy}'),
            ),
          );
        },
      ),
      // Floating Action Button to add new suggestions
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSuggestionDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
