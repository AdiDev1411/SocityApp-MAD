import 'package:flutter/material.dart';

class Resource {
  final String title;
  final String category;

  Resource({required this.title, required this.category});
}

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  static final List<Resource> _dummyResources = [
    Resource(title: 'Society Bye-Laws.pdf', category: 'Legal Documents'),
    Resource(title: 'Gymnasium Rules.pdf', category: 'Amenities'),
    Resource(title: 'Club House Booking Form.doc', category: 'Forms'),
    Resource(title: 'Audited Financials 2024.xls', category: 'Financials'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _dummyResources.length,
        itemBuilder: (context, index) {
          final resource = _dummyResources[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              leading: const Icon(Icons.source_outlined),
              title: Text(resource.title),
              subtitle: Text(resource.category),
              trailing: const Icon(Icons.download_for_offline_outlined),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
