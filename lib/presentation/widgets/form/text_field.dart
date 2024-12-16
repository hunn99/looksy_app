import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

// Daftar domain email yang valid
const List<String> validDomains = [
  'gmail.com',
  'yahoo.com',
  'outlook.com',
  'hotmail.com',
  'icloud.com',
  'aol.com',
];

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool isEmail;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.isEmail = false, // Tambahkan flag untuk validasi email
  });

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return '$label is required';
    }

    // Jika isEmail = true, lakukan validasi email
    if (isEmail) {
      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
          .hasMatch(value)) {
        return 'Please enter a valid email address';
      }

      final String emailDomain = value.split('@').last;
      if (!validDomains.contains(emailDomain)) {
        return 'Please use a trusted email domain';
      }
    }

    return null; // Validasi lolos
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: bodyBlack2),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            hintText: hintText,
            hintStyle: bodyGrey3,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: neutralTheme[100]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: neutralTheme),
            ),
          ),
          validator: _validate, // Gunakan fungsi validasi internal
        ),
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final FocusNode? focusNode;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.focusNode,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null; // Validasi lolos
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: bodyBlack2),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            hintText: widget.hintText,
            hintStyle: bodyGrey3,
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
                color: neutralTheme,
              ),
            ),
          ),
          validator: _validatePassword, // Validasi internal
        ),
      ],
    );
  }
}
