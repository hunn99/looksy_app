import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/data/datasources/remote_datasources/auth_remote_datasources.dart';
import 'package:looksy_app/presentation/pages/home/homepage.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';
import 'package:looksy_app/presentation/widgets/form/text_field.dart'; // Import AuthServices

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isPasswordVisible = false;
  bool _isLoading = false; // Menambahkan status loading
  final FocusNode _passwordFocusNode = FocusNode();

  // Define TextEditingControllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true; // Set loading to true when the registration starts
    });

    try {
      await AuthServices().signUp(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Beri pesan sukses dan arahkan ke login jika registrasi berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
      context.push('/login');
    } catch (e) {
      // Tampilkan pesan error jika gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up: $e')),
      );
    } finally {
      setState(() {
        _isLoading =
            false; // Set loading to false once the registration is done
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: _unfocus,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 24),
                      Image.asset(
                        'assets/logos/Logo_black.png',
                        height: 40,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Welcome to Looksy!',
                        style: TextStyle(
                          fontSize: 32,
                          color: neutralTheme,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Discover your perfect hairstyle tailored to your unique face shape. Let\'s get started on your style journey!',
                        style: TextStyle(
                          fontSize: 16,
                          color: neutralTheme[300],
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        label: 'Email',
                        hintText: 'Enter your Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        label: 'Username',
                        hintText: 'Enter your Username',
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 12),
                      PasswordField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        label: 'Password',
                        hintText: 'Enter your Password',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LargeFillButton(
                  label: 'Sign Up',
                  onPressed: () {
                    context.go('/home');
                  },
                  isDisabled: false,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: neutralTheme,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: neutralTheme,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
