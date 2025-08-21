import 'package:flutter/material.dart';

// --- Data Models and Enums ---
enum FlatStatus { owner, closed, rent, dead, shop }

final Map<FlatStatus, Color> statusColors = {
  FlatStatus.owner: const Color(0xFF6CB4EE),
  FlatStatus.closed: Colors.grey.shade400,
  FlatStatus.rent: Colors.orange.shade400,
  FlatStatus.dead: Colors.black87,
  FlatStatus.shop: Colors.purple.shade400,
};

class FlatInfo {
  final String number;
  FlatStatus status;
  FlatInfo({required this.number, required this.status});
}

// --- Main Widget ---
class WingDetailsScreen extends StatefulWidget {
  final int? totalFloors;
  final int? unitsPerFloor;
  final List<FlatInfo>? initialFlats;

  const WingDetailsScreen({
    super.key,
    this.totalFloors,
    this.unitsPerFloor,
    this.initialFlats,
  });

  @override
  State<WingDetailsScreen> createState() => _WingDetailsScreenState();
}

class _WingDetailsScreenState extends State<WingDetailsScreen> {
  late List<FlatInfo> _flats;

  @override
  void initState() {
    super.initState();
    // If we receive an initial list (for editing), use it.
    // Otherwise, generate a new list from the floor/unit count.
    if (widget.initialFlats != null) {
      // Create a deep copy to allow editing without affecting the original until saved.
      _flats = widget.initialFlats!.map((flat) {
        return FlatInfo(number: flat.number, status: flat.status);
      }).toList();
    } else {
      _flats = _generateFlats();
    }
  }

  List<FlatInfo> _generateFlats() {
    final List<FlatInfo> generatedFlats = [];
    final floors = widget.totalFloors ?? 0;
    final units = widget.unitsPerFloor ?? 0;

    for (int floor = floors; floor >= 1; floor--) {
      for (int unit = 1; unit <= units; unit++) {
        final flatNumber = '${floor}0$unit';
        generatedFlats.add(FlatInfo(number: flatNumber, status: FlatStatus.owner));
      }
    }
    return generatedFlats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Flat Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildLegend(),
            const SizedBox(height: 24),
            Expanded(
              child: _buildFlatsGrid(),
            ),
            const SizedBox(height: 16),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: FlatStatus.values.map((status) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: statusColors[status],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(status.name[0].toUpperCase() + status.name.substring(1)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildFlatsGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.unitsPerFloor ?? 4, // Use a default if null
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _flats.length,
      itemBuilder: (context, index) {
        final flat = _flats[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              int currentStatusIndex = flat.status.index;
              int nextStatusIndex = (currentStatusIndex + 1) % FlatStatus.values.length;
              flat.status = FlatStatus.values[nextStatusIndex];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: statusColors[flat.status],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                flat.number,
                style: TextStyle(
                  color: flat.status == FlatStatus.dead ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wing details saved!')),
          );
          // Return the updated list of flats to the previous screen.
          Navigator.pop(context, _flats);
        },
        child: const Text('Save'),
      ),
    );
  }
}
