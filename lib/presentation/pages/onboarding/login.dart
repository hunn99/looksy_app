import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/data/dto/requests/login_dto.dart';
import 'package:looksy_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';
import 'package:looksy_app/presentation/widgets/form/text_field.dart';
// import 'package:looksy_app/presentation/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // Define GlobalKey for Form
  final _formKey = GlobalKey<FormState>();

  // Define TextEditingControllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is AuthSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            context.go('/home');
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
                          'Welcome back to Looksy!',
                          style: TextStyle(
                            fontSize: 32,
                            color: neutralTheme,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ready to find your next great look? Log in and explore new styles just for you!',
                          style: bodyGrey1,
                        ),
                        const SizedBox(height: 32),
                        CustomTextField(
                          label: 'Email',
                          hintText: 'Enter your email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          isEmail: true, // Aktifkan validasi email
                        ),
                        const SizedBox(height: 12),
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
                    label: 'Login',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthLoginEvent(
                              params: LoginDto(
                                  email: _emailController.text,
                                  password: _passwordController.text),
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
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: neutralTheme,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push('/register');
                        },
                        child: Text(
                          'Sign up',
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
