import 'package:flutter/material.dart';

// A data model to represent a vehicle
class Vehicle {
  final String flatNumber;
  final String ownerName;
  final String vehicleType; // "2-Wheeler" or "4-Wheeler"
  final String vehicleNumber;

  Vehicle({
    required this.flatNumber,
    required this.ownerName,
    required this.vehicleType,
    required this.vehicleNumber,
  });
}

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  // Dummy data for the vehicles list
  static final List<Vehicle> _dummyVehicles = [
    Vehicle(flatNumber: 'A-101', ownerName: 'Rajesh Patel', vehicleType: '4-Wheeler', vehicleNumber: 'GJ01AB1234'),
    Vehicle(flatNumber: 'A-201', ownerName: 'Amit Singh', vehicleType: '2-Wheeler', vehicleNumber: 'GJ01CD5678'),
    Vehicle(flatNumber: 'B-101', ownerName: 'Vikram Rathod', vehicleType: '4-Wheeler', vehicleNumber: 'GJ01EF9012'),
    Vehicle(flatNumber: 'B-101', ownerName: 'Vikram Rathod', vehicleType: '2-Wheeler', vehicleNumber: 'GJ01GH3456'),
    Vehicle(flatNumber: 'C-301', ownerName: 'Nisha Verma', vehicleType: '2-Wheeler', vehicleNumber: 'GJ01IJ7890'),
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate totals for the summary header
    final totalFourWheelers = _dummyVehicles.where((v) => v.vehicleType == '4-Wheeler').length;
    final totalTwoWheelers = _dummyVehicles.length - totalFourWheelers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicles Directory'),
      ),
      body: Column(
        children: [
          _buildSummaryCard(totalFourWheelers, totalTwoWheelers),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _dummyVehicles.length,
              itemBuilder: (context, index) {
                return _buildVehicleCard(_dummyVehicles[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(int fourWheelers, int twoWheelers) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text('$fourWheelers', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('4-Wheelers'),
              ],
            ),
            const SizedBox(height: 40, child: VerticalDivider()),
            Column(
              children: [
                Text('$twoWheelers', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('2-Wheelers'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(Vehicle vehicle) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  vehicle.vehicleType == '4-Wheeler' ? Icons.directions_car_filled : Icons.two_wheeler,
                  color: Colors.indigo,
                ),
                const SizedBox(width: 16),
                Text(
                  vehicle.vehicleNumber,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
              ],
            ),
            const Divider(height: 20),
            Text('Owner: ${vehicle.ownerName}'),
            const SizedBox(height: 8),
            Text('Flat: ${vehicle.flatNumber}'),
          ],
        ),
      ),
    );
  }
}
