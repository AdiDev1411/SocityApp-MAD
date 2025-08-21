import 'package:flutter/material.dart';

class Announcement {
  final String title;
  final String content;
  final DateTime date;

  Announcement({required this.title, required this.content, required this.date});
}

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final List<Announcement> _announcements = [
    Announcement(title: 'Water Supply Interruption', content: 'Water supply will be interrupted tomorrow from 10 AM to 2 PM.', date: DateTime(2025, 8, 17)),
    Announcement(title: 'Pest Control Drive', content: 'Quarterly pest control on Saturday. Please ensure kitchen is accessible.', date: DateTime(2025, 8, 15)),
  ];

  void _showAddAnnouncementDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Announcement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Title"),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(hintText: "Content"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Post'),
              onPressed: () {
                if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                  setState(() {
                    _announcements.insert(0, Announcement(
                      title: titleController.text,
                      content: contentController.text,
                      date: DateTime.now(),
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
        title: const Text('Announcements'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _announcements.length,
        itemBuilder: (context, index) {
          final announcement = _announcements[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(announcement.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(announcement.content),
                  const Divider(height: 24),
                  Text('Posted on: ${announcement.date.day}/${announcement.date.month}/${announcement.date.year}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAnnouncementDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
