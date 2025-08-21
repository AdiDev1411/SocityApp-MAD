import 'package:flutter/material.dart';
import '../wing_details_screen.dart'; // Import for FlatInfo model

// A data model to represent a member
class Member {
  final String flatNumber;
  final String name;
  final String ownershipType; // "Owner" or "Rental"
  final int familyMembers;
  final String? vehicleNumber; // Nullable if no vehicle

  Member({
    required this.flatNumber,
    required this.name,
    required this.ownershipType,
    required this.familyMembers,
    this.vehicleNumber,
  });
}

class MembersScreen extends StatelessWidget {
  final Map<String, List<FlatInfo>> wingsData;

  const MembersScreen({super.key, required this.wingsData});

  @override
  Widget build(BuildContext context) {
    // Convert the received wing data into a single list of members
    final List<Member> allMembers = [];
    wingsData.forEach((wingLetter, flats) {
      for (var flat in flats) {
        // Create dummy member data based on the flat info
        allMembers.add(Member(
          flatNumber: '$wingLetter-${flat.number}',
          name: 'Occupant of ${flat.number}',
          ownershipType: flat.status == FlatStatus.rent ? 'Rental' : 'Owner',
          familyMembers: 4, // Dummy data
          vehicleNumber: (int.parse(flat.number) % 2 == 0) ? 'GJ01XY${flat.number}' : null, // Dummy data
        ));
      }
    });

    final totalOwners = allMembers.where((m) => m.ownershipType == 'Owner').length;
    final totalRentals = allMembers.length - totalOwners;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members Directory'),
      ),
      body: Column(
        children: [
          _buildSummaryCard(totalOwners, totalRentals),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: allMembers.length,
              itemBuilder: (context, index) {
                return _buildMemberCard(allMembers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(int owners, int rentals) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text('$owners', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('Owners'),
              ],
            ),
            const SizedBox(height: 40, child: VerticalDivider()),
            Column(
              children: [
                Text('$rentals', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('Rentals'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(Member member) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(member.flatNumber, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: member.ownershipType == 'Owner' ? Colors.green[100] : Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    member.ownershipType,
                    style: TextStyle(
                      color: member.ownershipType == 'Owner' ? Colors.green[800] : Colors.orange[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Text('Primary Member: ${member.name}'),
            const SizedBox(height: 8),
            Text('Family Members: ${member.familyMembers}'),
            const SizedBox(height: 8),
            Text('Vehicle: ${member.vehicleNumber ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
