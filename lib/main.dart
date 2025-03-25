import 'package:flutter/material.dart';

void main() {
  runApp(const SignupApp());
}

class SignupApp extends StatelessWidget {
  const SignupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _dobController = TextEditingController();

  String name = '';
  String email = '';
  String password = '';
  String dob = '';

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDOB(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dob = "${picked.month}/${picked.day}/${picked.year}";
      _dobController.text = dob;
    }
  }

  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(name: name),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup Page")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    // Name
                    TextFormField(
                      decoration: _inputStyle('Name', Icons.person),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter name' : null,
                      onSaved: (value) => name = value!,
                    ),
                    const SizedBox(height: 16),
                    // Email
                    TextFormField(
                      decoration: _inputStyle('Email', Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter email';
                        final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$');
                        if (!regex.hasMatch(value)) return 'Invalid email format';
                        return null;
                      },
                      onSaved: (value) => email = value!,
                    ),
                    const SizedBox(height: 16),
                    // DOB
                    TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      onTap: () => _selectDOB(context),
                      decoration: _inputStyle('Date of Birth', Icons.calendar_today),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter DOB' : null,
                    ),
                    const SizedBox(height: 16),
                    // Password
                    TextFormField(
                      obscureText: true,
                      decoration: _inputStyle('Password', Icons.lock),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter password';
                        if (value.length < 8) return 'Minimum 8 characters';
                        if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
                            !RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Include letters and numbers';
                        }
                        return null;
                      },
                      onSaved: (value) => password = value!,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
                      ),
                    )
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

class ConfirmationScreen extends StatelessWidget {
  final String name;
  const ConfirmationScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Center(
        child: Text(
          'Welcome, $name!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}