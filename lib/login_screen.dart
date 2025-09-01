import 'package:flutter/material.dart';

// Enum to represent the user roles for type safety
enum UserRole { admin, owner }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.owner;
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // For the admin flow, we navigate to the create new screen
      if (_selectedRole == UserRole.admin) {
        Navigator.pushReplacementNamed(
          context,
          '/create_new',
          arguments: 'Admin User', // Default name for login
        );
      } else {
        // For the owner flow, navigate to the home screen
        final ownerData = {
          'role': _selectedRole,
          'name': 'Owner User', // Default name for login
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
        title: const Text('Login'),
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
                    Icon(Icons.login, size: 80, color: primaryColor),
                    const SizedBox(height: 16),
                    Text(
                      'Login to Your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Welcome back! Please enter your credentials',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
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
                        if (!value.contains('@')) {
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
                        hintText: 'Enter your password',
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
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
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
                    
                    const SizedBox(height: 32),
                    
                    // Login Button
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Login'),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Forgot password functionality coming soon!'),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up',
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
