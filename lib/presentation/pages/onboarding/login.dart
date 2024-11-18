import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';
import 'package:looksy_app/presentation/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthServices _authServices = AuthServices(); // Inisialisasi AuthServices
  bool _isLoading = false; // Untuk mengatur loading state

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  // Fungsi untuk login
  Future<void> _handleLogin() async {
    // Cek apakah email dan password sudah diisi
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi email terlebih dahulu!')),
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi password terlebih dahulu!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final isLoggedIn = await _authServices.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (isLoggedIn) {
        // Jika login berhasil, arahkan ke halaman home
        context.go('/home');
      } else {
        // Jika login gagal, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email atau password salah')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              padding: const EdgeInsets.all(24),
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
                    'Welcome back to Looksy!',
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0xFF1b1b1b),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ready to find your next great look? Log in and explore new styles just for you!',
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
                      hintStyle: const TextStyle(
                          color: Color(0xFFD1D1D1), fontSize: 16),
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
                      hintStyle: const TextStyle(
                          color: Color(0xFFD1D1D1), fontSize: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xFFE7E7E7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xFF1b1b1b)),
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
                  const SizedBox(height: 200),
                  Button(
                    label: _isLoading ? 'Loading...' : 'Login',
                    onTap: _isLoading ? null : _handleLogin,
                    colorText: Colors.white,
                    colorBackground: neutralTheme,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: neutralTheme,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push('/register');
                        },
                        child: const Text(
                          'Sign up',
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
