import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/data/dto/requests/register_dto.dart';
import 'package:looksy_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';
import 'package:looksy_app/presentation/widgets/form/text_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  // Define GlobalKey for Form
  final _formKey = GlobalKey<FormState>();

  // Define TextEditingControllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is AuthSuccess) {
            // Navigator.of(context, rootNavigator: true).pop(); // Menutup dialog
            context.push('/home');
          }

          if (state is AuthFailed) {
            Navigator.of(context, rootNavigator: true).pop(); // Menutup dialog

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to sign up: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: GestureDetector(
                onTap: _unfocus,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey, // Attach Form Key
                    child: Column(
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
                        const SizedBox(height: 4),
                        Text(
                          'Discover your perfect hairstyle tailored to your unique face shape. Let\'s get started on your style journey!',
                          style: bodyGrey1,
                        ),
                        const SizedBox(height: 32),
                        // Email Field
                        CustomTextField(
                          label: 'Email',
                          hintText: 'Enter your email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          isEmail: true, // Aktifkan validasi email
                        ),

                        const SizedBox(height: 12),
                        // Username Field
                        CustomTextField(
                          label: 'Username',
                          hintText: 'Enter your username',
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 12),
                        // Password Field
                        PasswordField(
                          controller: _passwordController,
                          label: 'Password',
                          hintText: 'Enter your password',
                        ),
                      ],
                    ),
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
                      if (_formKey.currentState!.validate()) {
                        // Only submit if form is valid
                        context.read<AuthBloc>().add(AuthRegisterEvent(
                              params: RegisterDto(
                                email: _emailController.text,
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            ));
                      }
                    },
                    isDisabled: state is AuthLoading,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: neutralTheme,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push('/login');
                        },
                        child: Text(
                          'Login',
                          style: bodyBlack5,
                        ),
                      ),
                    ],
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
