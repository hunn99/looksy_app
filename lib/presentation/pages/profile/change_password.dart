import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Change Password',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          backgroundColor: Color(0xFF1b1b1b),
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(IconsaxOutline.arrow_left, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your new password must be different from previous used passwords.",
                style: TextStyle(
                  fontSize: 16,
                  color: neutralTheme,
                ),
              ),
              const SizedBox(height: 40),
              // Current Password
              TextField(
                obscureText: _obscureCurrentPassword,
                decoration: InputDecoration(
                  labelText: "Current Password",
                  labelStyle: TextStyle(
                    color: neutralTheme[200]!,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(color: neutralTheme[100]!, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: neutralTheme, width: 1.5),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrentPassword
                          ? IconsaxOutline.eye_slash
                          : IconsaxOutline.eye,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),
              // New Password
              TextField(
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: "New Password",
                  labelStyle: TextStyle(
                    color: neutralTheme[200]!,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(color: neutralTheme[100]!, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: neutralTheme, width: 1.5),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? IconsaxOutline.eye_slash
                          : IconsaxOutline.eye,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),
              // Confirm Password
              TextField(
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(
                    color: neutralTheme[200]!,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(color: neutralTheme[100]!, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: neutralTheme, width: 1.5),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? IconsaxOutline.eye_slash
                          : IconsaxOutline.eye,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neutralTheme,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Implementasi fungsi simpan password baru
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
