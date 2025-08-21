import 'package:flutter/material.dart';

class Event {
  final String name;
  final DateTime date;
  final String location;

  Event({required this.name, required this.date, required this.location});
}

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<Event> _events = [
    Event(name: 'Ganesh Chaturthi Celebration', date: DateTime(2025, 9, 7), location: 'Club House'),
    Event(name: 'Annual Sports Day', date: DateTime(2025, 12, 22), location: 'Society Ground'),
  ];

  void _showAddEventDialog() {
    final nameController = TextEditingController();
    final locationController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(hintText: "Event Name"), autofocus: true),
              const SizedBox(height: 16),
              TextField(controller: locationController, decoration: const InputDecoration(hintText: "Location")),
              const SizedBox(height: 16),
              StatefulBuilder(builder: (context, setState) {
                return TextButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2020), lastDate: DateTime(2030));
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Text('Date: ${selectedDate.toLocal()}'.split(' ')[0]),
                );
              })
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Create'),
              onPressed: () {
                if (nameController.text.isNotEmpty && locationController.text.isNotEmpty) {
                  setState(() {
                    _events.add(Event(
                      name: nameController.text,
                      location: locationController.text,
                      date: selectedDate,
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
        title: const Text('Events'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(event.date.day.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
                      Text('${event.date.month}/${event.date.year}', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Location: ${event.location}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
