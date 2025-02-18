import 'package:flutter/material.dart';
import 'package:sales_app/screens/auth/sales_rep_login_screen.dart';
import 'package:sales_app/services/auth_service.dart';

class SalesRepSignUpScreen extends StatefulWidget {
  const SalesRepSignUpScreen({super.key});

  @override
  _SalesRepSignUpScreenState createState() => _SalesRepSignUpScreenState();
}

class _SalesRepSignUpScreenState extends State<SalesRepSignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Rep Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter both email and password')),
                  );
                  return;
                }

                final user = await _authService.signUpSalesRep(email, password);
                if (user != null) {
                  print('Sales Rep signed up: ${user.email}');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SalesRepLoginScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign-up failed. Please try again.')),
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
