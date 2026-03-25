import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../../../widgets/common/custom_button.dart';
import '../../../../widgets/common/custom_text_field.dart';
import '../../../../core/utils/validators.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      await authProvider.signUp(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (mounted) {
        if (authProvider.errorMessage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authProvider.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeRide Sign Up'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.directions_bike,
                    size: 100,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: 'Email',
                    hintText: 'Enter your email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    controller: _passwordController,
                    obscureText: true,
                    validator: Validators.validatePassword,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Confirm Password',
                    hintText: 'Confirm your password',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: _validateConfirmPassword,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: _signup,
                    isLoading: authProvider.isLoading,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Already have an account? Login'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
