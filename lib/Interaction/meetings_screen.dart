import 'package:flutter/material.dart';

class Meeting {
  String title;
  DateTime date;
  String status;

  Meeting({required this.title, required this.date, required this.status});
}

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  final List<Meeting> _meetings = [
    Meeting(title: 'Monthly Committee Meeting', date: DateTime(2025, 9, 5, 19, 0), status: 'Scheduled'),
    Meeting(title: 'AGM Discussion', date: DateTime(2025, 8, 15, 11, 0), status: 'Completed'),
  ];

  void _showMeetingDialog({Meeting? existingMeeting}) {
    final isEditing = existingMeeting != null;
    final titleController = TextEditingController(text: existingMeeting?.title ?? '');
    DateTime selectedDate = existingMeeting?.date ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Meeting' : 'Add New Meeting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Meeting Title"),
                autofocus: true,
              ),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return TextButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Text('Date: ${selectedDate.toLocal()}'.split(' ')[0]),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text(isEditing ? 'Save' : 'Add'),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    if (isEditing) {
                      existingMeeting.title = titleController.text;
                      existingMeeting.date = selectedDate;
                    } else {
                      _meetings.add(Meeting(
                        title: titleController.text,
                        date: selectedDate,
                        status: 'Scheduled',
                      ));
                    }
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
        title: const Text('Meetings'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _meetings.length,
        itemBuilder: (context, index) {
          final meeting = _meetings[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: const Icon(Icons.timer_outlined, size: 40),
              title: Text(meeting.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Date: ${meeting.date.day}/${meeting.date.month}/${meeting.date.year}'),
              trailing: Text(
                meeting.status,
                style: TextStyle(
                  color: meeting.status == 'Scheduled' ? Colors.blue : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onLongPress: () {
                _showMeetingDialog(existingMeeting: meeting);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showMeetingDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
