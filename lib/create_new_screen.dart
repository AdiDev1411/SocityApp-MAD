import 'package:flutter/material.dart';

class CreateNewScreen extends StatefulWidget {
  const CreateNewScreen({super.key});

  @override
  State<CreateNewScreen> createState() => _CreateNewScreenState();
}

class _CreateNewScreenState extends State<CreateNewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _wingsController = TextEditingController(text: '3');
  final _nameController = TextEditingController();
  String? _selectedState;
  String? _selectedCity;

  final List<String> _states = ['Gujarat', 'Maharashtra', 'Rajasthan'];
  final Map<String, List<String>> _cities = {
    'Gujarat': ['Anand', 'Ahmedabad', 'Surat', 'Vadodara'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur'],
  };

  @override
  void dispose() {
    _wingsController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Receive the user's name from the auth screen
    final String userName = ModalRoute.of(context)!.settings.arguments as String;
    _nameController.text = userName; // Set the name in the text field

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Trial'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfoCard(),
              const SizedBox(height: 24),
              const Text(
                'Building Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 16),
              _buildTextField(label: 'Name', controller: _nameController),
              const SizedBox(height: 16),
              _buildTextField(label: 'Total Wings/blocks/building', controller: _wingsController, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildStateDropdown(),
              const SizedBox(height: 16),
              _buildCityDropdown(),
              const SizedBox(height: 16),
              _buildTextField(label: 'Pincode', initialValue: '388120', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextField(label: 'Address', initialValue: 'XYZ', maxLines: 3),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final int numberOfWings = int.tryParse(_wingsController.text) ?? 0;
                    // Pass both the user name and number of wings to the next screen
                    final setupArgs = {
                      'userName': _nameController.text,
                      'totalWings': numberOfWings,
                    };
                    Navigator.pushReplacementNamed(
                      context,
                      '/setup_wings',
                      arguments: setupArgs,
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Colors.blue[50],
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue.shade100),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'This is a 7 days free trial.\nPost Charges: Rs 20 Per house per month',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, String? initialValue, TextEditingController? controller, int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildStateDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedState,
      hint: const Text('State'),
      decoration: const InputDecoration(labelText: 'State'),
      items: _states.map((String state) {
        return DropdownMenuItem<String>(
          value: state,
          child: Text(state),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedState = newValue;
          _selectedCity = null;
        });
      },
      validator: (value) => value == null ? 'Please select a state' : null,
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCity,
      hint: const Text('City'),
      decoration: const InputDecoration(labelText: 'City'),
      items: (_selectedState == null ? <String>[] : _cities[_selectedState]!)
          .map<DropdownMenuItem<String>>((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: _selectedState == null ? null : (newValue) {
        setState(() {
          _selectedCity = newValue;
        });
      },
      validator: (value) => value == null ? 'Please select a city' : null,
    );
  }
}
