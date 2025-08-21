import 'package:flutter/material.dart';
import 'wing_details_screen.dart';

class WingConfigScreen extends StatefulWidget {
  final String wingName;

  const WingConfigScreen({super.key, required this.wingName});

  @override
  State<WingConfigScreen> createState() => _WingConfigScreenState();
}

class _WingConfigScreenState extends State<WingConfigScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _floorController = TextEditingController();
  final _unitController = TextEditingController();
  int _selectedFormatIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.wingName;
    _floorController.text = '4';
    _unitController.text = '4';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _floorController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configure Wing - ${widget.wingName}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(controller: _nameController, label: 'Name'),
              const SizedBox(height: 20),
              _buildTextField(controller: _floorController, label: 'Total Floor', keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              _buildTextField(controller: _unitController, label: 'Maximum Unit Per Floor', keyboardType: TextInputType.number),
              const SizedBox(height: 30),
              const Text(
                'Choose Number Format from below Example',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildFormatSelection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final int totalFloors = int.tryParse(_floorController.text) ?? 0;
              final int unitsPerFloor = int.tryParse(_unitController.text) ?? 0;

              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WingDetailsScreen(
                    totalFloors: totalFloors,
                    unitsPerFloor: unitsPerFloor,
                  ),
                ),
              );

              // If the details screen was saved, it will return the list of flats.
              // Pop this screen and pass that data back to the setup screen.
              if (result != null && result is List<FlatInfo>) {
                Navigator.pop(context, result);
              }
            }
          },
          child: const Text('Next'),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        return null;
      },
    );
  }

  Widget _buildFormatSelection() {
    final List<List<String>> formatExamples = [
      ['301', '302', '303', '201', '202', '203', '101', '102', '103'],
      ['7', '8', '9', '4', '5', '6', '1', '2', '3'],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      itemCount: formatExamples.length,
      itemBuilder: (context, index) {
        return _buildFormatExample(index, formatExamples[index]);
      },
    );
  }

  Widget _buildFormatExample(int index, List<String> items) {
    bool isSelected = _selectedFormatIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFormatIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
            width: isSelected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: items.length,
          itemBuilder: (context, itemIndex) {
            return Center(
              child: Text(
                items[itemIndex],
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            );
          },
        ),
      ),
    );
  }
}
