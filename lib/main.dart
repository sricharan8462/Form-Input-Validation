import 'package:flutter/material.dart';

void main() => runApp(const SignupApp());

class SignupApp extends StatelessWidget {
  const SignupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignupPage(),
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
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value!,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter name' : null,
              ),
              // (email, dob, password...) same as before
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationScreen(name: name),
                      ),
                    );
                  }
                },
                child: const Text('Sign Up'),
              )
            ],
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
      appBar: AppBar(title: const Text('Confirmation')),
      body: Center(child: Text('Welcome, $name!')),
    );
  }
}
