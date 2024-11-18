import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';
import 'package:looksy_app/presentation/services/auth_services.dart'; // Import AuthServices

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;  // Menambahkan status loading
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

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
    _confirmPasswordFocusNode.dispose();
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
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Beri pesan sukses dan arahkan ke login jika registrasi berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful')),
      );
      context.push('/login');
    } catch (e) {
      // Tampilkan pesan error jika gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false once the registration is done
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: _unfocus,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Image.asset(
                    'assets/images/Logo_black.png',
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
                  Text('Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      hintText: 'Enter your Email',
                      hintStyle: TextStyle(
                          color: neutralTheme[200]!,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: neutralTheme[100]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: neutralTheme),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Username',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      hintText: 'Enter your Username',
                      hintStyle:
                          TextStyle(color: neutralTheme[200]!, fontSize: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: neutralTheme[100]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: neutralTheme),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(fontSize: 16),
                    focusNode: _passwordFocusNode,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      hintText: 'Enter your Password',
                      hintStyle:
                          TextStyle(color: neutralTheme[200]!, fontSize: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: neutralTheme[100]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: neutralTheme),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: Icon(
                          _isPasswordVisible
                              ? IconsaxOutline.eye
                              : IconsaxOutline.eye_slash,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 110),
                  Button(
                    label: _isLoading ? 'Signing up...' : 'Sign up', // Ganti teks tombol saat loading
                    onTap: _isLoading // Nonaktifkan tombol saat loading
                        ? null
                        : () async {
                            // Validasi input
                            if (_emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Harap isi email terlebih dahulu!')),
                              );
                            } else if (_usernameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Harap isi username terlebih dahulu!')),
                              );
                            } else if (_passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Harap isi password terlebih dahulu!')),
                              );
                            } else {
                              await _register(); // Panggil fungsi _register
                            }
                          },
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    textSize: 16,
                    colorText: Colors.white,
                    colorBackground: neutralTheme,
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
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
