import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../../../widgets/common/custom_button.dart';
import '../../../../widgets/common/custom_text_field.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/constants/route_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isFormVisible = false;
  bool _isIconAnimated = false;

  @override
  void initState() {
    super.initState();
    // Trigger animations after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isFormVisible = true;
        _isIconAnimated = true;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      await authProvider.signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (mounted && authProvider.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeRide Login'),
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
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.elasticOut,
                    transform: Matrix4.identity()
                      ..scale(_isIconAnimated ? 1.0 : 0.0),
                    child: const Icon(
                      Icons.directions_bike,
                      size: 100,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 32),
                  AnimatedOpacity(
                    opacity: _isFormVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeIn,
                    child: AnimatedSlide(
                      offset: Offset(0.0, _isFormVisible ? 0.0 : 0.3),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      child: CustomTextField(
                    label: 'Email',
                    hintText: 'Enter your email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                    prefixIcon: const Icon(Icons.email),
                  ),
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
                  ),
                  const SizedBox(height: 24),
                  AnimatedOpacity(
                    opacity: _isFormVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeIn,
                    child: CustomButton(
                    text: 'Login',
                    onPressed: _login,
                    isLoading: authProvider.isLoading,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteConstants.signup);
                    },
                    child: const Text('Don\'t have an account? Sign up'),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                    },
                    child: const Text('Forgot password?'),
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
