import 'package:flutter/material.dart';

class Proposal {
  final String title;
  final String submittedBy;
  final String status; // "Pending", "Approved", "Rejected"

  Proposal({required this.title, required this.submittedBy, required this.status});
}

class ProposalsScreen extends StatelessWidget {
  const ProposalsScreen({super.key});

  static final List<Proposal> _dummyProposals = [
    Proposal(title: 'Installation of Solar Panels on Terrace', submittedBy: 'Mr. Sharma (A-301)', status: 'Approved'),
    Proposal(title: 'Proposal for Kids Play Area Upgrade', submittedBy: 'Mrs. Gupta (B-402)', status: 'Pending'),
    Proposal(title: 'Request for Additional CCTV Cameras', submittedBy: 'Mr. Khan (C-101)', status: 'Rejected'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposals'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _dummyProposals.length,
        itemBuilder: (context, index) {
          final proposal = _dummyProposals[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              title: Text(proposal.title),
              subtitle: Text('By: ${proposal.submittedBy}'),
              trailing: Chip(
                label: Text(proposal.status),
                backgroundColor: proposal.status == 'Approved'
                    ? Colors.green.shade100
                    : (proposal.status == 'Pending' ? Colors.orange.shade100 : Colors.red.shade100),
              ),
            ),
          );
        },
      ),
    );
  }
}
