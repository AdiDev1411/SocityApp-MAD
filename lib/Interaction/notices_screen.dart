import 'package:flutter/material.dart';

class Notice {
  final String title;
  final String issuedBy;
  final DateTime date;

  Notice({required this.title, required this.issuedBy, required this.date});
}

class NoticesScreen extends StatefulWidget {
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  final List<Notice> _notices = [
    Notice(title: 'Notice for Pending Maintenance Dues', issuedBy: 'Society Office', date: DateTime(2025, 8, 10)),
    Notice(title: 'Parking Regulations Update', issuedBy: 'Management Committee', date: DateTime(2025, 8, 5)),
  ];

  void _showAddNoticeDialog() {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Issue New Notice'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Notice Title"),
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Issue'),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    _notices.insert(0, Notice(
                      title: titleController.text,
                      issuedBy: 'Admin',
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
        title: const Text('Notices'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _notices.length,
        itemBuilder: (context, index) {
          final notice = _notices[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              leading: const Icon(Icons.campaign_outlined, color: Colors.indigo),
              title: Text(notice.title),
              subtitle: Text('Issued by: ${notice.issuedBy} on ${notice.date.day}/${notice.date.month}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoticeDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
