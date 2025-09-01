import 'package:flutter/material.dart';

// Enum to represent the user roles for type safety
enum UserRole { admin, owner }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  UserRole _selectedRole = UserRole.owner;
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree to the terms and conditions'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // For the admin flow, we navigate to the create new screen
      if (_selectedRole == UserRole.admin) {
        Navigator.pushReplacementNamed(
          context,
          '/create_new',
          arguments: _nameController.text,
        );
      } else {
        // For the owner flow, navigate to the home screen
        final ownerData = {
          'role': _selectedRole,
          'name': _nameController.text,
        };
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: ownerData,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1976D2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.person_add, size: 80, color: primaryColor),
                    const SizedBox(height: 16),
                    Text(
                      'Create Your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join our community today!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        prefixIcon: Icon(Icons.person_outline, color: primaryColor),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length < 2) {
                          return 'Name must be at least 2 characters long';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                        prefixIcon: Icon(Icons.email_outlined, color: primaryColor),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Create a strong password',
                        prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Re-enter your password',
                        prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscureConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Role Selection
                    DropdownButtonFormField<UserRole>(
                      value: _selectedRole,
                      items: UserRole.values.map((UserRole role) {
                        return DropdownMenuItem<UserRole>(
                          value: role,
                          child: Row(
                            children: [
                              Icon(
                                role == UserRole.admin ? Icons.admin_panel_settings : Icons.person,
                                color: primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(role.name[0].toUpperCase() + role.name.substring(1)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (UserRole? newValue) {
                        setState(() {
                          _selectedRole = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select your role',
                        prefixIcon: Icon(Icons.person_pin_circle_outlined, color: primaryColor),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Terms and Conditions Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (bool? value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                          activeColor: primaryColor,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _agreeToTerms = !_agreeToTerms;
                              });
                            },
                            child: Text(
                              'I agree to the Terms and Conditions and Privacy Policy',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Sign Up'),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
